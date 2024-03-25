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
        sms_type,
        case 
            when scheduled_at is null then null
            else scheduled_at::timestamp
        end as scheduled_at,
        sent,
        sent_at,--TODO: Cast to datetime 
        case when cost is null then 0 else cost::int end as cost,
        moderator,
        user_id,
        approved,
        approved_by,
        case 
            when approved_at is null then null
            else approved_at::timestamp end  as approved_at,
        delivery_status,
        case 
            when  status_date is null then null
            else status_date::timestamp
        end as status_date,
        created_at::timestamp as created_at,
        case 
            when updated_at is null then null
            else updated_at::timestamp
        end as updated_at,
        created_by,
        updated_by,
        send_failure_reason
    from
        {{ source('smartcollect', 'sms') }}
    where
        deleted_at is null
)

select * from sms
