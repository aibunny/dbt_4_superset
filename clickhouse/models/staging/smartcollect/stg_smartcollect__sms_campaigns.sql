with sms_campaigns as (
    select
        id as sms_campaign_id,
        upper(title) as sms_campaign_name,
        organization_id,
        description,
        target as sms_campaign_target,
        runs_to as sms_campaign_end_date,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at
    
    from 
        {{source('smartcollect','sms_campaigns')}}
    where
        deleted_at is null and active= 1 
)

select * from sms_campaigns