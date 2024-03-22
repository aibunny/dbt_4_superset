select
    id as phone_id,
    phone,
    phone_national,
    phone_type,
    carrier,
    country_code,
    phonable_id,
    phonable_type,
    is_primary,
    notes,
    external_id,
    is_skiptraced,
    skiptrace_id,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
from
    {{ source('smartcollect', 'phones') }}
where
    deleted_at is null and active = 1