select
    id as approval_level_id,
    {{ coalesce_to_uuid('organization_id') }},
    module as approval_level_module,
    description as approval_level_description,
    approval_name,
    approval_level as approval_level,
    is_required,
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

    
from 
    {{ source('smartcollect', 'approval_levels')}}
where
    deleted_at is null 
