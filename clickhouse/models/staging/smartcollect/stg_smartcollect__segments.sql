select
    id as segment_id,
    upper(title) as segment,
    description as segment_description,
    is_visible as segment_is_visible,
    created_by,
    updated_by,
    created_at,
    updated_at

from 
    {{ source('smartcollect', 'segments') }}
where
    deleted_at is null and active = 1
