import logging
import os
import zipfile
import yaml

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

    dashboards = get_dashboard_folders(target_folder)

    for dash in dashboards:
        dash_database_path = os.path.join(target_folder, f'{dash}/databases')

        database_files = [file for file in os.listdir(dash_database_path)
                          if file.endswith('yaml')]

        for file in database_files:
            yaml_file_path = os.path.join(database_files, file)

            # read the database yaml file
            with open(yaml_file_path, 'r') as yaml_file:
                data = yaml.safe_load(yaml_file)

            pass


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

    logging.info("All done Database and Datasets Created on superset!")
