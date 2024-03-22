select
    id as employer_id,
    title as employer_name,
    debtor_id,
    is_current,
    created_by as created_by,
    updated_by as updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
from
    {{ source('smartcollect', 'employers') }}
where
    deleted_at is null 