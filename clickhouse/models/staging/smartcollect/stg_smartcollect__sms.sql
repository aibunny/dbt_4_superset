with sms as (
    select
        id as sms_id,
        message,
        phone,
        {{ coalesce_to_uuid('case_file_id') }},
        {{ coalesce_to_uuid('organization_id') }},
        {{ coalesce_to_uuid('sms_template_id') }},
        {{ coalesce_to_uuid('sms_campaign_id') }},
        {{ coalesce_to_uuid('campaign_batch_id') }},
        gateway,
        gateway_id,        
        target,
        batch_no,
        sms_type as sms_type,
        {{ coalesce_to_timestamp('scheduled_at')}},
        sent,
        sent_at,--TODO: Cast to datetime 
        case when cost is null then 0 else cost::int end as cost,
        moderator,
        user_id,
        approved,
        approved_by,
        {{ coalesce_to_timestamp('approved_at')}},
        delivery_status as delivery_status,
        {{ coalesce_to_timestamp('created_at')}},
        {{ coalesce_to_timestamp('updated_at')}},
        created_by,
        updated_by,
        send_failure_reason
    from
        {{ source('smartcollect', 'sms') }}
    where
        deleted_at is null
)

select * from sms
