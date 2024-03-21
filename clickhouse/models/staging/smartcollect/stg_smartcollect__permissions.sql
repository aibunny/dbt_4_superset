select
    id as permission_id,
    name as permission_name,
    display_name as permission_display_name,
    namespace as permission_namespace,
    description as permission_description,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at
from
    {{ source('smartcollect', 'permissions') }}
