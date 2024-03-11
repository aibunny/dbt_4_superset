import logging
import os
import zipfile
import yaml


from typing import List

from .create_db import load_env_variables
from .superset_api import Superset

logging.basicConfig(
    format='%(asctime)s - %(levelname)s - %(message)s', level=logging.INFO)


def unzip_dashboard_files(dashboards_file_path):
    logging.info('Unzipping Dashboard file(s)')

    try:
        dashboard_zip_files = [
            file for file in
            os.listdir(dashboards_file_path) if file.endswith('.zip')
        ]

        if len(dashboard_zip_files) == 0:
            raise FileNotFoundError(
                "No dashboard zip files found in the provided path")

        # create a target folder, overwrite if exists
        target_folder = os.path.join(
            dashboards_file_path, 'extracted_dashboards')
        os.makedirs(target_folder, exist_ok=True)

        for zip_file in dashboard_zip_files:
            # extract the contents of the zip file into the target folder
            zip_file_path = os.path.join(dashboards_file_path, zip_file)
            with zipfile.ZipFile(zip_file_path, 'r') as file:
                file.extractall(target_folder)

        logging.info("All %s file(s) Unzipped successfully",
                     len(dashboard_zip_files))

        return target_folder

    except Exception as e:
        logging.error("unzip_dashboard_files encountered: %s", e)


def get_dashboard_folders(target_folder):

    all_dashboards = os.listdir(target_folder)
    logging.info("Got %s dashboard folder(s)", len(all_dashboards))
    return all_dashboards


def update_database_details(target_folder):

    sql_uri = (
        f"{os.getenv('DB_ENGINE')}+{os.getenv('DB_DRIVER')}://"
        f"{os.getenv('DB_USER')}:XXXXXXXXXX@"
        f"{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}"
    )

    dashboards = get_dashboard_folders(target_folder)

    dashboard_paths = []

    logging.info("Editing DB details for %s file(s)", len(dashboards))

    try:

        for dash in dashboards:

            # get dashboard path
            dash_path = os.path.join(target_folder, dash)

            dashboard_paths.append(dash_path)

            dash_database_path = os.path.join(dash_path, 'databases')

            # get database config yaml
            database_files = [
                file for file in os.listdir(dash_database_path)
                if file.endswith('.yaml')]

            logging.info(
                "Editing %s file(s) found in %s",
                len(database_files), dash
            )

            for file in database_files:

                yaml_file_path = os.path.join(dash_database_path, file)

                # read the database yaml file
                with open(yaml_file_path, 'r') as yaml_file:
                    data = yaml.safe_load(yaml_file)
                    # update the db details
                    data['sqlalchemy_uri'] = sql_uri
                    data['database_name'] = os.getenv(
                        "SST_DB_NAME", "SMARTCOLLECT")

                # Rename the file to SST_DB_NAME.yaml
                new_file = f"{data['database_name']}.yaml"
                new_file_path = os.path.join(dash_database_path, new_file)

                # Remove the old yaml file
                os.remove(yaml_file_path)

                # Write the new file
                with open(new_file_path, 'w') as new_yaml_file:
                    yaml.dump(data, new_yaml_file, default_flow_style=True)

        logging.info("Database details updated successfully  in the %s dashboard folder(s)",
                     len(dashboard_paths))

        return dashboard_paths

    except Exception as e:
        logging.error(" Update_database_details encountered: %s", e)


def zip_updated_dashboards(dashboard_paths: List[str], dashboard_file_path: str) -> List[str]:
    logging.info("Zipping updated dashboard files")
    zipped_dashboard_files = []

    try:
        parent_dir = os.path.join(dashboard_file_path, 'updated_dashboards')
        os.makedirs(parent_dir, exist_ok=True)

        for dash in dashboard_paths:
            dashboard_name = os.path.basename(dash)
            zip_dash_name = f"{dashboard_name}_updated.zip"
            zip_filepath = os.path.join(parent_dir, zip_dash_name)

            with zipfile.ZipFile(zip_filepath, "w") as zip_file:
                for root, dirs, files in os.walk(dash):
                    for file in files:
                        file_path = os.path.join(root, file)
                        arcname = os.path.join(
                            dashboard_name, os.path.relpath(file_path, dash))
                        zip_file.write(file_path, arcname)

            zipped_dashboard_files.append(zip_filepath)
            print(zip_filepath)

        logging.info("All files Zipped successfully")
        return zipped_dashboard_files

    except Exception as e:
        logging.error("zip_updated_dashboards encountered: %s", e)
        raise Exception("Error zipping updated files")


def create_dashboards(superset: Superset, zipped_dashboards_path: list):
    logging.info("Pushing Dashboards to Superset")

    try:
        for dashboard in zipped_dashboards_path:

            with open(dashboard, 'rb') as dash:

                logging.info("Importing this dashboard: %s",
                             f'{os.path.basename(dashboard)}')

                files = {'formData': (
                    f'{os.path.basename(dashboard)}', dash, 'application/zip')}

                data = {
                    'passwords': '{"databases/{{DatabaseYAMLFile}}": "{{DatabasePassword}}"}',
                    'overwrite': os.getenv("OVERWRITE", "true")
                }

                database_file = f'{os.getenv("SST_DB_NAME","SMARTCOLLECT")}.yaml'
                database_pass = os.getenv("DB_PASSWORD")

                data['passwords'] = data['passwords'].replace(
                    '{{DatabaseYAMLFile}}', database_file)
                data['passwords'] = data['passwords'].replace(
                    '{{DatabasePassword}}', database_pass)
                print(data)
                headers = {'Accept': 'application/json'}

                # Separate the file and form data in the request
                r = superset.request(
                    "POST",
                    "/dashboard/import",
                    files=files,
                    data=data,
                    headers=headers
                )

                logging.info("Superset response: %s", r)

    except Exception as e:
        logging.error("Importing dashboards to Superset failed because: %s", e)


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

    try:
        target_folder = unzip_dashboard_files(dashboards_file_path)
    except FileNotFoundError as e:
        logging.error(f"No zip file found at {dashboards_file_path}")

    updated_dashboard_paths = update_database_details(target_folder)

    zipped_dashboard_paths = zip_updated_dashboards(
        updated_dashboard_paths, dashboards_file_path)

    create_dashboards(superset, zipped_dashboard_paths)

    logging.info(
        "All Dashboard in %s  Created on superset!",
        dashboards_file_path
    )
