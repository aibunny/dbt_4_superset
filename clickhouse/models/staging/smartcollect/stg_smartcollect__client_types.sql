select
    id as client_type_id,
    title as client_type,
    description as client_type_description,
    active as client_type_is_active,
    created_by,
    updated_by,
    deleted_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at
from {{source('smartcollect','client_types')}}