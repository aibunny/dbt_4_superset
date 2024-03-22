with whatsapp_messages as(
    select
        wm.whatsapp_message_id as whatsapp_message_id,
        wm.case_file_id as case_file_id,
        wm.organization_id as organization_id,
        wm.business_account_id as business_account_id,
        wm.sent as whatsapp_message_sent,
        wm.whatsapp_account_id as whatsapp_account_id,
        wm.message_direction as whatsapp_message_direction,
        wm.message_type as whatsapp_message_type,
        case when wm.message_status is null then 'unknown' else wm.message_status end as whatsapp_message_status,
        wm.sender as whatsapp_message_sender
    from
        {{ref('stg_smartcollect__whatsapp_messages')}} wm

)

select * from whatsapp_messages