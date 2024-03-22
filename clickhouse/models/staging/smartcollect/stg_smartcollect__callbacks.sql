select
    id as callback_id,
    case_file_id,
    phone_no as callback_phone_number,
    user_id,
    organization_id,
    callback_time::timestamp as callback_time,
    status as callback_status,
    notes as callback_notes,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
    
from
    {{source('smartcollect', 'callbacks')}}

where
    deleted_at is null

