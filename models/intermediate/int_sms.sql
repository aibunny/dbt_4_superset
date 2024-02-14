with refined_sms as (
    select
        id as sms_id,
        case_file_id,
        gateway_id,
        sms_template_id,
        sms_campaign_id,
        campaign_batch_id,
        organization_id,
        target,
        sms_type,
        cost,
        moderator,
        user_id,
        approved,
        approved_by,
        delivery_status,
        sent_at
    from
        {{ ref('stg_smartcollect__sms')}}
    where 
        deleted_at is null and sent = 1 
)

select * from refined_sms