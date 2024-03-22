select
    id as approval_level_id,
    organization_id,
    module as approval_level_module,
    description as approval_level_description,
    approval_name as approval_level,
    approval_level,
    is_required,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
    
from {{ source('smartcollect', 'approval_levels')}}
where
    deleted_at is null 
