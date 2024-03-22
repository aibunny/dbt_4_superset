select
    id as next_action_id,
    title as next_action_title,
    description as next_action_description,
    tag as next_action_tag,
    slug as next_action_slug,
    created_by as created_by,
    updated_by as updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
from
    {{ source('smartcollect', 'next_actions') }}
where
    deleted_at is null and active = 1