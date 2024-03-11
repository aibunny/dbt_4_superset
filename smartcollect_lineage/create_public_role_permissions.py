import logging
import os
import json
from dotenv import load_dotenv
from .superset_api import Superset

load_dotenv()


logging.basicConfig(
    format='%(asctime)s - %(levelname)s - %(message)s', level=logging.INFO)


def get_permissions(superset: Superset) -> list:

    res = superset.request(
        'GET',
        '/security/permissions/?q={"page_size":100}'
    )

    permissions = os.getenv("PUBLIC_ROLE_PERMISSIONS")

    permission_list = [permission.strip()
                       for permission in permissions.split(',')]

    print("--------", permission_list)

    permission_ids = []
    for permission in res['result']:
        if permission["name"] in permission_list:
            permission_ids.append(permission['id'])
    print("--------", permission_ids)
    return permission_ids


def get_public_role_id(superset: Superset) -> int:

    res = superset.request(
        'GET',
        '/security/roles/',
    )

    for permission in res['result']:
        if permission['name'] == 'Public':
            return permission['id']


def create_permission(
        superset: Superset,
        permission_ids: list,
        public_role_id: int):

    payload = {
        "permission_view_menu_ids": permission_ids
    }

    superset.request(
        'POST',
        f'/security/roles/{public_role_id}/permissions',
        json=payload
    )
    return True


def main(
    superset_url,
    superset_access_token,
    superset_refresh_token
):

    # require at least one token for Superset
    assert superset_access_token is not None or superset_refresh_token is not None, \
        "Add ``SUPERSET_ACCESS_TOKEN`` or ``SUPERSET_REFRESH_TOKEN`` " \
        "to your environment variables or provide in CLI " \
        "via ``superset-access-token`` or ``superset-refresh-token``."

    superset = Superset(superset_url + '/api/v1',
                        access_token=superset_access_token, refresh_token=superset_refresh_token)

    logging.info("Starting the Create Public Role Permissions script!")

    permission_id_list = get_permissions(superset)

    public_role_id = get_public_role_id(superset)

    create_permission(superset, permission_id_list, public_role_id)
