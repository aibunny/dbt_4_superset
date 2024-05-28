import logging
import requests
import os
from dotenv import load_dotenv
from .superset_api import Superset

load_dotenv()


def embed_dash_on_smartcollect(
        smartcollect_url: str,
        slug: str,
        embedding_id: str,
        api_key: str
):
    logging.info(f"Embedding dashboard {slug}")
    smartcollect_url = smartcollect_url + '/api/v1/reports/dashboard-embeddings'

    payload = {
        "dashboard_id": embedding_id,
        "slug": slug,
        "rls": "team_id,organization_id,user_id,branch_id"
    }
    headers = {
        "X-API-KEY": api_key
    }
    response = requests.post(
        smartcollect_url,
        json=payload,
        headers=headers
    )

    # Optional: check the response
    if response.status_code == 200:
        logging.info(f"Successfully embedded dashboard {slug}")
    else:
        logging.error(f"Failed to embed dashboard {slug}: {response.status_code} {response.text}")

    return response


def get_dashboards(superset: Superset) -> list:
    logging.info("Pulling existing Dashboards From SST")
    dashboards_on_sst = []

    res = superset.request(
        'GET',
        '/dashboard/',
    )
    dashboards = res['result']

    for dash in dashboards:
        dash_id = dash['id']
        dash_title = dash['dashboard_title']
        dash['dash_slug'] = ''

        if dash_title == 'Overview':
            dash['dash_slug'] = 'overview'
        elif dash_title == 'Calls':
            dash['dash_slug'] = 'live-calls'
        elif dash_title == 'Campaigns':
            dash['dash_slug'] = 'live-campaigns'
        elif dash_title == 'Activities':
            dash['dash_slug'] = 'live-activity'
        elif dash_title == 'Sessions':
            dash['dash_slug'] = 'live-sessions'
        elif dash_title == 'Organization Performance':
            dash['dash_slug'] = 'performance-organizations'
        elif dash_title == 'Organization Users':
            dash['dash_slug'] = 'performance-users'
        elif dash_title == 'PTPs':
            dash['dash_slug'] = 'ptps'
        elif dash_title == 'SMS':
            dash['dash_slug'] = 'communication-sms'
        elif dash_title == 'Whatsapp':
            dash['dash_slug'] = 'communication-whatsapp'
        elif dash_title == 'Emails':
            dash['dash_slug'] = 'communication-emails'
        else:
            logging.warning(f"Unexpected dashboard title: {dash_title}")

        dash_details = {
            "dash_id": dash_id,
            "dash_slug": dash['dash_slug'],
        }
        dashboards_on_sst.append(dash_details)

    return dashboards_on_sst


def get_dash_embedding_configuration(
        superset: Superset,
        smartcollect_url: str,
        api_key: str
):
    dashboards = get_dashboards(superset)

    for dash in dashboards:
        logging.info("Getting embedding configs for dash %s", dash["dash_slug"])
        dash_id = dash['dash_id']

        try:
            res = superset.request(
                'POST',
                f"/dashboard/{dash_id}/embedded",
                json={
                    "allowed_domains": [
                        smartcollect_url
                    ]
                }
            )
            dash['dash_uuid'] = res["result"]["uuid"]
            embed_dash_on_smartcollect(
                smartcollect_url=smartcollect_url,
                slug=dash['dash_slug'],
                embedding_id=dash['dash_uuid'],
                api_key=api_key
            )
        except Exception as e:
            logging.error("Experienced error %s getting embedding configs for dash %s", e, dash["dash_slug"])


def main(superset_url: str,
         env_file_path: str,
         superset_access_token: str,
         superset_refresh_token: str
):

    load_dotenv(dotenv_path=env_file_path)

    # require at least one token for Superset
    assert superset_access_token is not None or superset_refresh_token is not None, \
        "Add `SUPERSET_ACCESS_TOKEN` or `SUPERSET_REFRESH_TOKEN` " \
        "to your environment variables or provide in CLI " \
        "via `superset-access-token` or `superset-refresh-token`."

    superset = Superset(superset_url + '/api/v1',
                        access_token=superset_access_token,
                        refresh_token=superset_refresh_token)

    smartcollect_url = os.getenv('SMARTCOLLECT_URL')
    api_key = os.getenv('SMARTCOLLECT_API_KEY')
    get_dash_embedding_configuration(
        superset,
        smartcollect_url,
        api_key
    )

    logging.info("Start embedding dashboards")
