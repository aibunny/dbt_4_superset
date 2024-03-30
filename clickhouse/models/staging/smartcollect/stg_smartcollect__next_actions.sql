select
    id as next_action_id,
    title as next_action_title,
    description as next_action_description,
    tag as next_action_tag,
    slug as next_action_slug,
    created_by as created_by,
    updated_by as updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from
    {{ source('smartcollect', 'next_actions') }}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}