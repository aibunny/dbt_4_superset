with sms_campaigns as (
    select
        id as sms_campaign_id,
        title as sms_campaign_name,
        organization_id,
        description,
        target as sms_campaign_target,
        runs_to as sms_campaign_end_date,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}
    
    from 
        {{source('smartcollect','sms_campaigns')}}
    where
        deleted_at is null and active= {{ get_active_value(target.type)}}
)

select * from sms_campaigns