select
    id as segment_id,
    title as segment,
    description as segment_description,
    is_visible as segment_is_visible,
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from 
    {{ source(var('source_db'), 'segments') }}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}
