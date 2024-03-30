select
    id as permission_id,
    name as permission_name,
    display_name as permission_display_name,
    namespace as permission_namespace,
    description as permission_description,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from
    {{ source('smartcollect', 'permissions') }}
where
    deleted_at is null
