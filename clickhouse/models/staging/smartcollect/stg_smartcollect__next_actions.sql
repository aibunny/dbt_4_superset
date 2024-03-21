select
    id as next_action_id,
    title as next_action_title,
    description as next_action_description,
    tag as next_action_tag,
    slug as next_action_slug,
    active as next_action_is_active,
    created_by as next_action_created_by,
    updated_by as next_action_updated_by,
    deleted_by as next_action_deleted_by,
    created_at::timestamp as next_action_created_at,
    updated_at::timestamp as next_action_updated_at,
    deleted_at::timestamp as next_action_deleted_at
from
    {{ source('smartcollect', 'next_actions') }}
