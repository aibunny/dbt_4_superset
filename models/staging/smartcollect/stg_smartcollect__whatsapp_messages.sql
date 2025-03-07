select
    id as whatsapp_message_id,
    {{ coalesce_to_uuid('case_file_id') }},
    {{ coalesce_to_uuid('organization_id') }},
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
    created_at,
    case when approved_at is not null then approved_at::timestamp else approved_at end as approved_at,
    {{ coalesce_to_timestamp('updated_at')}}


from
    {{ source(var('source_db'), 'whatsapp_messages') }}
where 
    deleted_at is null 
