import logging
import os
import zipfile
import yaml
import json

from .create_db import load_env_variables
from .superset_api import Superset

logging.basicConfig(
    format='%(asctime)s - %(levelname)s - %(message)s', level=logging.INFO)


def unzip_dashboard_files(dashboards_file_path):
    logging.info('Unzipping Dashboard files')

    try:
        dashboard_zip_files = [
            file for file in
            os.listdir(dashboards_file_path) if file.endswith('.zip')
        ]

        if len(dashboard_zip_files) == 0:
            raise Exception(
                "The path provided doesn't contain any zip files")

        # create a target folder overwrite any if exists
        target_folder = os.path.join(
            dashboards_file_path, 'extracted_dashboards')
        os.makedirs(target_folder, exist_ok=True)

        for zip_file in dashboard_zip_files:

            # extract the contents of the zip file into the target folder
            zip_file_path = os.path.join(dashboards_file_path, zip_file)
            with zipfile.ZipFile(zip_file_path, 'r') as file:
                file.extractall(target_folder)

        return target_folder
    except Exception as e:
        logging.error(
            "%s", e)


def get_dashboard_folders(target_folder):
    logging.info("Getting extracted dashboard folders")
    all_dashboards = os.listdir(target_folder)
    return all_dashboards


def update_database_details(target_folder):

    logging.info("Editing DB details")

    sql_uri = (
        f"{os.getenv('DB_ENGINE')}+{os.getenv('DB_DRIVER')}://"
        f"{os.getenv('DB_USER')}:XXXXXXXXXX@"
        f"{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}"
    )

    dashboards = get_dashboard_folders(target_folder)
    dashboard_paths = []

    try:

        for dash in dashboards:

            # get dashboard path
            dash_path = os.path.join(target_folder, dash)

            dashboard_paths.append(dash_path)

            dash_database_path = os.path.join(dash_path, '/databases')

            # get database config yaml
            database_files = [file for file in os.listdir(dash_database_path)
                              if file.endswith('yaml')]

            for file in database_files:
                yaml_file_path = os.path.join(database_files, file)

                # read the database yaml file
                with open(yaml_file_path, 'r') as yaml_file:
                    data = yaml.safe_load(yaml_file)
                    # update the db details
                    data['sqlalchemy_uri'] = sql_uri
                    data['database_name'] = os.getenv(
                        "DB_NAME", "SMARTCOLLECT")

                # Rename the file to DB_NAME.yaml
                new_file = f"{data['database_name']}.yaml"
                new_file_path = os.path.join(dash_database_path, new_file)

                # Remove the old yaml file
                os.remove(yaml_file_path)

                # Write the new file
                with open(new_file_path, 'w') as new_yaml_file:
                    yaml.dump(data, new_yaml_file, default_flow_style=False)

        return dashboard_paths

    except Exception as e:
        logging.error("%s", e)


def zip_updated_dashboards(
    dashboard_paths: list,
    dashboard_file_path: str
):

    zipped_dashboard_files = []
    parent_dir = os.path.dirname(dashboard_file_path)

    try:
        for path in dashboard_paths:
            dashboard_name = os.path.basename(path)

            zip_dash_name = f"{dashboard_name}_updated.zip"

            zip_filepath = os.join(parent_dir, zip_dash_name)

            # Ensure the output directory exists
            os.makedirs(os.path.dirname(zip_filepath), exist_ok=True)

            # Create a zip archive for each dashboard
            with zipfile.ZipFile(zip_filepath, 'w', zipfile.ZIP_DEFLATED) as zip_file:
                for root, dirs, files in os.walk(path):
                    for file in files:
                        file_path = os.path.join(root, file)
                        arcname = os.path.relpath(file_path, path)
                        zip_file.write(file_path, arcname)

            zipped_dashboard_files.append(zip_filepath)

        return zipped_dashboard_files

    except Exception as e:
        logging.error("%s", e)
        return zipped_dashboard_files


def create_dashboards(
        superset: Superset,
        zipped_dashboards_path: list):

    logging.info("Pushing Dashboards to superset")

    try:
        for dashboard in zipped_dashboards_path:
            files = {'file': (f'{os.path.basename(dashboard)}',
                              open(dashboard, 'rb'),
                              'application/zip')
                     }
            data = {
                'passwords': json.dumps({
                    f"database/{os.getenv('DB_NAME','SMARTCOLLECT')}.yaml":
                    os.getenv("DB_PASSWORD")
                })
            }

            superset("POST", "dashboard/import/", json=data, files=files)

    except Exception as e:
        logging.error("Importing dashboards to superset failed because: %s", e)


def main(
    env_file_path: str,
    dashboards_file_path: str,
    superset_url: str,
    superset_access_token: str,
    superset_refresh_token: str
):
    # require at least one token for Superset
    assert superset_access_token is not None or superset_refresh_token is not None, \
        "Add ``SUPERSET_ACCESS_TOKEN`` or ``SUPERSET_REFRESH_TOKEN`` " \
        "to your environment variables or provide in CLI " \
        "via ``superset-access-token`` or ``superset-refresh-token``."

    superset = Superset(superset_url + '/api/v1',
                        access_token=superset_access_token, refresh_token=superset_refresh_token)

    logging.info("Starting the PUSH DASHBOARDS script!")

    load_env_variables(env_file_path)

    target_folder = unzip_dashboard_files(dashboards_file_path)
    updated_dashboard_paths = update_database_details(target_folder)

    zipped_dashboard_paths = zip_updated_dashboards(updated_dashboard_paths)

    create_dashboards(superset, zipped_dashboard_paths)

    logging.info("All Dashboard in %s  Created on superset!",
                 dashboards_file_path)
