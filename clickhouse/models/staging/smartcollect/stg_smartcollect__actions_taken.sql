select
    id as action_id,
    title as action_title,
    slug as action_slug,
    description as action_description,
    active as action_is_active,
    tag as action_tag,
    created_by,
    updated_by,
    deleted_by,
    created_at::timestamp as created_at,
    deleted_at::timestamp as deleted_at
    
from 
    {{ source('smartcollect', 'actions_taken')}}
where
    deleted_at is null and active = 1
