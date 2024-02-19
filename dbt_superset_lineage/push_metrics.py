import json
import logging
import re
import time

from .superset_api import Superset
from requests import HTTPError
from  . push_descriptions import get_datasets_from_superset, get_tables_from_dbt, \
    convert_markdown_to_plain_text

logging.basicConfig(format='%(asctime)s - %(levelname)s - %(message)s', level=logging.INFO)


def add_superset_metrics(superset, dataset):
    logging.info("Pulling metrics from superset")
    
    res = superset.request('GET', f'/dataset/{dataset[id]}')
    result = res['result']
    
    dataset['metrics'] = result['metrics']
    
    return dataset



def delete_superset_metrics(dataset_id:int, metric_id:int):
    logging.info("Deleting metric from superset with id %s", metric_id)
    Superset.request('DELETE', f'/dataset/{dataset_id}/metric/{metric_id}')
    

def merge_metrics_info(dataset, tables):
    logging.info("Merging metrics info from Superset and manifest.json file.")
    
    key = dataset['key']
    sst_metrics = dataset['metrics']
    dbt_meta = tables.get(key, []).get('meta',{})
    
    
    old_sst_metrics = []
    
    new_sst_metrics = []
    
    for metric in sst_metrics:
        
        old_metric_attr = []
        
        old_metric_attr['expression'] = metric['expression']
        old_metric_attr['metric_name'] = metric['metric_name']
        old_metric_attr['metric_type'] = metric['metrics_type']
        old_metric_attr['verbose_name'] = metric['verbose_name']
        old_metric_attr['extra'] = metric['extra'] 
        old_metric_attr['currency'] = metric['currency'] 
        old_metric_attr['d3format'] = metric['d3format'] 
        
        old_sst_metrics.append(old_metric_attr)
        
        #delete existing metrics on superset        
        delete_superset_metrics(dataset[id],metric['id'])
        
        if 'superset_metrics' in dbt_meta:
            
            for metric in dbt_meta['superset_metrics']:
                new_metric_attr = []
                
                new_metric_attr['expression'] = convert_markdown_to_plain_text(metric['expression']) 
                new_metric_attr['metric_type'] = convert_markdown_to_plain_text(metric['metrics_type'])
                new_metric_attr['verbose_name'] = convert_markdown_to_plain_text(metric['verbose_name'])
                new_metric_attr['metric_name'] = convert_markdown_to_plain_text(metric['metric_key'])
                new_metric_attr['extra'] = convert_markdown_to_plain_text(metric['extra']) or ''
                new_metric_attr['currency'] = convert_markdown_to_plain_text(metric['currency']) or ''
                new_metric_attr['d3format'] = convert_markdown_to_plain_text(metric['d3format']) or ''

                new_sst_metrics.append(new_metric_attr)
            
            sst_metrics_set = { tuple(old_sst_metrics_attr) for old_sst_metrics_attr in old_sst_metrics }
            dbt_metrics_set = { tuple(new_sst_metrics_attr) for new_sst_metrics_attr in new_sst_metrics}

            unique_metrics = sst_metrics_set.union(dbt_metrics_set)
            new_metrics = [list(metric) for metric in unique_metrics]
            
            dataset['new_metrics'] = new_metrics
            
            return dataset
        
        
        
                
def put_metrics_to_superset(superset, dataset):
    logging.info("Putting models and metrics to superset")
    
    new_metrics = dataset['new_metrics']
    
    payload = {
        "metrics": new_metrics
    }
        
    superset.request('PUT', f'/dataset/{dataset['id']}', json = payload)    




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
            put_metrics_to_superset(superset, sst_dataset_w_metrics_new)
        except HTTPError as e:
            logging.error("The dataset with ID=%d wasn't updated. Check the error below.",
                          sst_dataset_id, exc_info=e)

    logging.info("All done!")
        