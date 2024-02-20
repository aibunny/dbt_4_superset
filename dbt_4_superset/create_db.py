import logging
import os
from dotenv import load_dotenv
load_dotenv(dotenv_path=)
from .superset_api import Superset


logging.basicConfig(format='%(asctime)s - %(levelname)s - %(message)s', level=logging.INFO)

def load_env_variables(env_file_path):
    logging.info("Loading environment variables")        
    r = load_dotenv(dotenv_path=env_file_path)
    
    if r is not True:
        logging.error(f"Failed to load environment variables from file {env_file_path}")
    

def create_db(superset:Superset, db_configs: dict):
    logging.info("Creating database on superset")
    superset.request("POST","/database/", json = db_configs)



def get_db_configs():
    logging.info("Getting database config from .env")
    
    db_uri = postgres
    
    db_configs =  {
        "allow_ctas": "true",
        "allow_cvas": "true",
        "allow_dml": "true",
        "allow_file_upload": os.getenv("DATABASE_ENGINE","false"),
        "allow_run_async": "true",
        "cache_timeout": 0,
        "database_name": "Smartcollect",
        "driver": os.getenv("DATABASE_DRIVER","psycopg2"),
        "engine": os.getenv("DATABASE_ENGINE","postgres"),
        "username":os.getenv("DATABASE_ENGINE","postgres"),
        "expose_in_sqllab": "true",
        "impersonate_user": "true",
        "is_managed_externally": "true",
        "sqlalchemy_uri": "postgres://postgres:b3puv9792qw@10.10.0.105:5432"


        }

