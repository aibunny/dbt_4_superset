select
    id as segment_id,
    title as segment,
    description as segment_description,
    is_visible as segment_is_visible,
    active as segment_active,
    created_by,
    updated_by,
    deleted_by,
    created_at,
    updated_at,
    deleted_at
from {{ source('smartcollect', 'segments') }}