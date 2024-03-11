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
    else:
        logging.info(
            f"Successfully loaded environment variables from file {env_file_path}")


def create_db(superset: Superset, db_configs: dict):

    try:
        logging.info("Creating database on superset")
        res = superset.request("POST", "/database", json=db_configs)

        id = res['id']

        return id
    except Exception as e:
        logging.info("Creating database failed due to: %s", e)


def get_db_configs(env_file_path: str) -> dict:
    logging.info("Getting database config from .env")

    load_env_variables(env_file_path)

    if os.getenv("SQLALCHEMY_URI"):
        sql_uri = os.getenv("SQLALCHEMY_URI")
    else:
        sql_uri = (
            f"{os.getenv('DB_ENGINE')}+{os.getenv('DB_DRIVER')}://"
            f"{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@"
            f"{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
        )

    db_configs = {
        "database_name": os.getenv("SST_DB_NAME", "SMARTCOLLECT"),
        "engine": os.getenv("DB_ENGINE", "postgres"),
        "sqlalchemy_uri": sql_uri
    }

    return db_configs


def create_dataset(superset: Superset, db_id: int):
    logging.info("Creating Datasets on superset")

    tables = os.getenv("TABLES")

    if tables is not None:
        tables = tables.split(',')

        logging.info(
            "Creating %s of the tables found on Superset", len(tables))

        for name in tables:
            payload = {
                "always_filter_main_dttm": False,
                "database": db_id,  # database id on superset
                "is_managed_externally": True,
                "normalize_columns": False,
                "owners": [
                    1
                ],
                "schema": os.getenv("DB_SCHEMA", "analytics"),
                "table_name": name
            }

            superset.request(
                'POST',
                "/dataset/",
                json=payload
            )
    else:
        logging.info(
            "skipping creating datasets since no tables were provided in the .env"
        )


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

    logging.info("Starting the CREATE DB/DATASETS script!")

    db_configs = get_db_configs(env_file_path)

    db_id = create_db(superset, db_configs)

    # create physical dataset after creating db
    create_dataset(superset, db_id)

    logging.info("All done Database and Datasets Created on superset!")
