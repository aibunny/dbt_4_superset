select
    id as client_type_id,
    title as client_type,
    description as client_type_description,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
from 
    {{source('smartcollect','client_types')}}
where
    deleted_at is null and active = 1