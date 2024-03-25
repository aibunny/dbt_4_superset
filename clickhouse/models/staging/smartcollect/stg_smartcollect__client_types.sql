select
    id as client_type_id,
    upper(title) as client_type,
    description as client_type_description,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

from 
    {{source('smartcollect','client_types')}}
where
    deleted_at is null and active = 1