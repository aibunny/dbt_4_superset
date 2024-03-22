select
    id as permission_id,
    name as permission_name,
    display_name as permission_display_name,
    namespace as permission_namespace,
    description as permission_description,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

from
    {{ source('smartcollect', 'permissions') }}
where
    deleted_at is null
