with refined_sms_campaigns as (
    select
        id as sms_campaign_id,
        organization_id,
        title as sms_campaign,
        target,
        runs_to
    from 
        {{ref('stg_smartcollect__sms_campaigns')}}
    where active = 1 and deleted_at is null
)

select * from refined_sms_campaigns