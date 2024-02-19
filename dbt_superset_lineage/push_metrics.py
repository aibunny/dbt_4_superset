import json
import logging
import requests

from .superset_api import Superset
from requests import HTTPError
from  . push_descriptions import get_datasets_from_superset, \
    convert_markdown_to_plain_text

logging.basicConfig(format='%(asctime)s - %(levelname)s - %(message)s', level=logging.INFO)


def get_tables_from_dbt(dbt_manifest, dbt_db_name):
    tables = {}
    
    for table_type in ['nodes', 'sources']:
        manifest_subset = dbt_manifest[table_type]

        for table_key_long in manifest_subset:
            table = manifest_subset[table_key_long]
            name = table['name']
            schema = table['schema']
            database = table['database']
            table_key_short = schema + '.' + name
            columns = table['columns']
            description = table['description']
            meta = table['meta']            

            if dbt_db_name is None or database == dbt_db_name:
                # fail if it breaks uniqueness constraint
                assert table_key_short not in tables, \
                    f"Table {table_key_short} is a duplicate name (schema + table) " \
                    f"across databases. " \
                    "This would result in incorrect matching between Superset and dbt. " \
                    "To fix this, remove duplicates or add the ``dbt_db_name`` argument."

                tables[table_key_short] = {'columns': columns, 'description': description, 'meta' : meta}

    assert tables, "Manifest is empty!"

    return tables



def add_superset_metrics(superset, dataset):
    logging.info("Pulling metrics from superset")
    
    res = superset.request('GET', f'/dataset/{dataset["id"]}')
    result = res['result']
    
    dataset['metrics'] = result['metrics']
    
    return dataset



def delete_superset_metrics(superset,dataset):
    metrics = dataset['metrics']
    
    for metric in metrics:
        superset.request('DELETE', f'/dataset/{dataset["id"]}/metric/{metric["id"]}')
        logging.info("Deleting metric from superset with id %s", metric["id"])
    
    

def merge_metrics_info(dataset, tables):
    logging.info("Merging metrics info from Superset and manifest.json file.")
    
    key = dataset['key']
    sst_metrics = dataset['metrics']
    dbt_meta = tables.get(key, []).get('meta', {})
    
    old_sst_metrics = []
    new_sst_metrics = []
    
    if sst_metrics is not None:
        logging.info("Pulling metrics found on Superset")
        for metric in sst_metrics:
            old_metric_attr = {
                'expression': metric['expression'],
                'metric_name': metric['metric_name'],
                'metric_type': metric['metric_type'],
                'verbose_name': metric['verbose_name'],
                'extra': metric['extra'],
                'currency': metric['currency'],
                'd3format': metric['d3format']
            }
            old_sst_metrics.append(frozenset(old_metric_attr.items()))
            
    
    if 'superset_metrics' in dbt_meta:
        for metric in dbt_meta['superset_metrics']:
            new_metric_attr = {
                'expression': convert_markdown_to_plain_text(metric['expression']),
                'metric_type': convert_markdown_to_plain_text(metric['type']) ,
                'verbose_name': convert_markdown_to_plain_text(metric['label']),
                'metric_name': convert_markdown_to_plain_text(metric['name']),
                'extra':'null',
                'currency': 'null',
                'd3format': 'null'
            }
            new_sst_metrics.append(frozenset(new_metric_attr.items()))
            
    else:
        logging.info("superset_metrics not found in dbt dataset.meta")
    
    sst_metrics_set = set(old_sst_metrics)
    dbt_metrics_set = set(new_sst_metrics)

    unique_metrics = sst_metrics_set.union(dbt_metrics_set)
    new_metrics = [dict(metric) for metric in unique_metrics]
    
    dataset['new_metrics'] = new_metrics
        
    return dataset
        
        
                
def put_metrics_to_superset(superset, dataset):
    logging.info("Putting models and metrics to superset")
    
    new_metrics = dataset['new_metrics']

    payload = {
        "metrics": new_metrics
    }
    payload = json.dumps(payload)
    
    print(payload)
    
    superset.request(
        'PUT', 
        f'/dataset/{dataset["id"]}',
        json = payload
        )    




def main(dbt_project_dir, dbt_db_name,
         superset_url, superset_db_id, superset_access_token, superset_refresh_token):

    # require at least one token for Superset
    assert superset_access_token is not None or superset_refresh_token is not None, \
           "Add ``SUPERSET_ACCESS_TOKEN`` or ``SUPERSET_REFRESH_TOKEN`` " \
           "to your environment variables or provide in CLI " \
           "via ``superset-access-token`` or ``superset-refresh-token``."

    superset = Superset(superset_url + '/api/v1',
                        access_token=superset_access_token, refresh_token=superset_refresh_token)

    logging.info("Starting the script!")

    sst_datasets = get_datasets_from_superset(superset, superset_db_id)
    logging.info("There are %d physical datasets in Superset overall.", len(sst_datasets))

    with open(f'{dbt_project_dir}/target/manifest.json') as f:
        dbt_manifest = json.load(f)

    dbt_tables = get_tables_from_dbt(dbt_manifest, dbt_db_name)

    sst_datasets_dbt_filtered = [d for d in sst_datasets if d["key"] in dbt_tables]
    logging.info("There are %d physical datasets in Superset with a match in dbt.", len(sst_datasets_dbt_filtered))

    for i, sst_dataset in enumerate(sst_datasets_dbt_filtered):
        logging.info("Processing dataset %d/%d.", i + 1, len(sst_datasets_dbt_filtered))
        sst_dataset_id = sst_dataset['id']
        try:
            sst_dataset_metrics =add_superset_metrics(superset, sst_dataset)
            
            sst_dataset_w_metrics_new = merge_metrics_info(sst_dataset_metrics, dbt_tables)
            
            #delete existing metrics on superset        
            delete_superset_metrics(superset,sst_dataset_metrics)
            
            put_metrics_to_superset(superset, sst_dataset_w_metrics_new)
        except HTTPError as e:
            logging.error("The dataset with ID=%d wasn't updated. Check the error below.",
                          sst_dataset_id, exc_info=e)

    logging.info("All done!")
        