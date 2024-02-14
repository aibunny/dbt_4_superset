with refined_sms as (
    select
        id as sms_id,
        case_file_id,
        gateway_id,
        sms_teplate_id,
        sms_campaign_id,
        campaign_batch_id,
        organization_id,
        target,
        sms_type,
        scheduled_at,
        sent,
        sent_at,
        cost,
        moderator,
        user_id,
        approved,
        approved_by,
        approved_at,
        delivery_status
    from
        {{ ref('stg_smartcollect__sms')}}
    where 
        deleted_at is null
)

select * from refined_sms