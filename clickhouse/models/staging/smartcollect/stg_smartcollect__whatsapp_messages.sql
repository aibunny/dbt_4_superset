select
    id as whatsapp_message_id,
    case_file_id,
    organization_id,
    whatsapp_phone_number,
    whatsapp_phone_number_id,
    business_account_id,
    sender,
    recipient,
    message_direction,
    message,
    sent,
    whatsapp_account_id,
    message_type,
    message_status,
    payload,
    created_by,
    approved_by,
    updated_by,
    created_at::timestamp as created_at,
    approved_at::timestamp as approved_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at


from
    {{ source('smartcollect', 'whatsapp_messages') }}
where 
    deleted_at is null 
