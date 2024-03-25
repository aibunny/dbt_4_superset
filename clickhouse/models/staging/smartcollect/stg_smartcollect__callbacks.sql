select
    id as callback_id,
    case_file_id,
    phone_no as callback_phone_number,
    user_id,
    {{ coalesce_to_uuid('organization_id') }},
    callback_time::timestamp as callback_time,
    status as callback_status,
    notes as callback_notes,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

    
from
    {{source('smartcollect', 'callbacks')}}

where
    deleted_at is null

