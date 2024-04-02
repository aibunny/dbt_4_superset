select
    id as employer_id,
    title as employer_name,
    debtor_id,
    is_current,
    created_by as created_by,
    updated_by as updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from
    {{ source(var('source_db'), 'employers') }}
where
    deleted_at is null 