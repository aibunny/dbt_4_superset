import requests
import os
import logging
import time
from dotenv import load_dotenv
from .create_db import main as create_db_main
from .create_dashboards import main as create_dashboards_main
from .push_descriptions import main as push_descriptions_main
from .push_metrics import main as push_metrics_main
from .create_public_role_permissions import main as create_public_role_permissions_main
from .embed_dashboard import main as embed_dashboard_main
load_dotenv()

logging.basicConfig(
    format='%(asctime)s - %(levelname)s - %(message)s', level=logging.INFO)


def get_superset_tokens():
    logging.info("Getting Superset access token")

    try:
        res = requests.post(
            url=f'{os.getenv("SUPERSET_URL")}/api/v1/security/login',
            json={
                "username": os.getenv("SUPERSET_USERNAME"),
                "password": os.getenv("SUPERSET_PASSWORD"),
                "refresh": False,
                "provider": "db"
            }
        )

        res.raise_for_status()  # Raises HTTPError for bad responses (4xx or 5xx)

        access_token = res.json()["access_token"]

        return access_token
    except requests.RequestException as e:
        logging.error(f"Error getting Superset access token: {e}")
        return None


def initiate_create_db(
        superset_url=None,
        superset_access_token=None,
        env_file_path=None,
        superset_refresh_token=None):

    logging.info("Intiating Create DB and Datasets")

    create_db_main(
        env_file_path,
        superset_url,
        superset_access_token,
        superset_refresh_token
    )


def initiate_push_descriptions(
        dbt_project_dir=None,
        dbt_db_name=None,
        superset_url=None,
        superset_db_id=None,
        superset_refresh_columns=None,
        superset_pause_after_update=5,
        superset_access_token=None,
        superset_refresh_token=None):

    logging.info("Initiating Push Descriptions")

    push_descriptions_main(
        dbt_project_dir,
        dbt_db_name,
        superset_url,
        superset_db_id,
        superset_refresh_columns,
        superset_pause_after_update,
        superset_access_token,
        superset_refresh_token
    )


def initiate_push_metrics(
        dbt_project_dir=None,
        dbt_db_name=None,
        superset_url=None,
        superset_db_id=None,
        superset_access_token=None,
        superset_refresh_token=None):

    logging.info("Initiate Push Metrics")

    push_metrics_main(
        dbt_project_dir,
        dbt_db_name,
        superset_url,
        superset_db_id,
        superset_access_token,
        superset_refresh_token
    )


def initiate_create_dashboards(
    env_file_path=None,
    dashboard_file_path=None,
    superset_url=None,
    superset_access_token=None,
    superset_refresh_token=None
):

    logging.info("Initiating Create Dashboards")

    create_dashboards_main(
        env_file_path,
        dashboard_file_path,
        superset_url,
        superset_access_token,
        superset_refresh_token
    )


def initiate_create_public_role_permissions(
    superset_url=None,
    superset_access_token=None,
    superset_refresh_token=None
):

    logging.info("Initiating Create Public roles permissions")

    create_public_role_permissions_main(
        superset_url,
        superset_access_token,
        superset_refresh_token
    )


def initiate_embed_dashboards(
        env_file_path=None,
        superset_url=None,
        superset_access_token=None,
        superset_refresh_token=None
):

    logging.info("Initiating Embedding Dashboards")

    embed_dashboard_main(
        superset_url,
        env_file_path,
        superset_access_token,
        superset_refresh_token)


def initiate(env_file_path=None):
    logging.info("Starting script ^_^")

    if env_file_path is None:
        # for situations where the command is initiated outside
        # smartcollect-lineage and testing
        init_env_file_path = os.getenv("ENV_PATH")
    else:
        init_env_file_path = env_file_path

    load_dotenv(dotenv_path=init_env_file_path)

    try:
        init_superset_access_token = get_superset_tokens()
        init_superset_url = os.getenv("SUPERSET_URL")
        init_dbt_project_dir = os.getenv("DBT_PROJECT_DIR")
        init_dash_path = os.getenv("DASHBOARDS_PATH", None)

        initiate_create_db(
            superset_url=init_superset_url,
            superset_access_token=init_superset_access_token,
            env_file_path=init_env_file_path
        )
        # sleep for 20 seconds allow time for all datasets to be created
        logging.info("Going to sleep allowing datasets to be created")

        time.sleep(20)

        initiate_push_metrics(
            superset_access_token=init_superset_access_token,
            superset_url=init_superset_url,
            dbt_project_dir=init_dbt_project_dir
        )

        initiate_push_descriptions(
            dbt_project_dir=init_dbt_project_dir,
            superset_url=init_superset_url,
            superset_access_token=init_superset_access_token
        )

        # initiate_create_public_role_permissions(
        #     superset_url=init_superset_url,
        #     superset_access_token=init_superset_access_token
        # )

        if init_dash_path is not None:

            initiate_create_dashboards(
                env_file_path=init_env_file_path,
                dashboard_file_path=init_dash_path,
                superset_url=init_superset_url,
                superset_access_token=init_superset_access_token
            )

            initiate_embed_dashboards(
                env_file_path=init_env_file_path,
                superset_url=init_superset_url,
                superset_access_token=init_superset_access_token
            )
        else:
            logging.info("SKIPPED CREATE & EMBED DASHBOARDS")
    except Exception as e:
        logging.error("Initializing scripts failed after encountering: %s", e)
