select
    id,
    message_id,
    message,
    message_from,
    message_to,
    device_id,
    timestamp,
    received_at,
    case_file_id,
    processed,
    created_at,
    updated_at,
    timestamp::timestamp as imestamp,
    received_at::timestamp as received_received_at
from 
    {{ source('smartcollect', 'received_sms') }}
where
    deleted_at is null