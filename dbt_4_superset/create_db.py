import logging
import os
from dotenv import load_dotenv
from .superset_api import Superset


logging.basicConfig(
    format='%(asctime)s - %(levelname)s - %(message)s', level=logging.INFO)


def load_env_variables(env_file_path: str):
    logging.info("Loading environment variables")
    r = load_dotenv(dotenv_path=env_file_path)

    if r is not True:
        logging.error(
            f"Failed to load environment variables from file {env_file_path}")


def create_db(superset: Superset, db_configs: dict):
    logging.info("Creating database on superset")
    superset.request("POST", "/database/", json=db_configs)


def get_db_configs(env_file_path: str) -> dict:
    logging.info("Getting database config from .env")

    load_env_variables(env_file_path)

    db_configs = {
        "allow_ctas": "true",
        "allow_cvas": "true",
        "allow_dml": "true",
        "allow_file_upload": os.getenv("ALLOW_FILE_UPLOAD", "false"),
        "allow_run_async": "true",
        "cache_timeout": 0,
        "database_name": os.getenv("DB_NAME", "Smartcollect"),
        "driver": os.getenv("DB_DRIVER", "psycopg2"),
        "engine": os.getenv("DB_ENGINE", "postgres"),
        "username": os.getenv("DB_USERNAME", "postgres"),
        "expose_in_sqllab": os.getenv("EXPOSE_IN_SQLLAB", "false"),
        "impersonate_user": "true",
        "is_managed_externally": "true",
        "sqlalchemy_uri": os.getenv("SQLALCHEMY_URI")
    }

    return db_configs


def main(
        env_file_path: str,
        superset_url: str,
        superset_access_token: str,
        superset_refresh_token: str):

    # require at least one token for Superset
    assert superset_access_token is not None or superset_refresh_token is not None, \
        "Add ``SUPERSET_ACCESS_TOKEN`` or ``SUPERSET_REFRESH_TOKEN`` " \
        "to your environment variables or provide in CLI " \
        "via ``superset-access-token`` or ``superset-refresh-token``."

    superset = Superset(superset_url + '/api/v1',
                        access_token=superset_access_token, refresh_token=superset_refresh_token)

    logging.info("Starting the script!")

    db_configs = get_db_configs(env_file_path)

    create_db(superset, db_configs)

    logging.info("All done Database Created on superset!")
