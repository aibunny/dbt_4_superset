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
    created_at,
    deleted_at::timestamp as deleted_at
    
from 
    {{ source(var('source_db'), 'actions_taken')}}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}
