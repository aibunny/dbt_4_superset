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
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from
    {{ source('smartcollect', 'phones') }}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}