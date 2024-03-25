select
    id as approval_level_id,
    {{ coalesce_to_uuid('organization_id') }},
    module as approval_level_module,
    description as approval_level_description,
    approval_name,
    appoval_level as approval_level,
    is_required,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

    
from 
    {{ source('smartcollect', 'approval_levels')}}
where
    deleted_at is null 
