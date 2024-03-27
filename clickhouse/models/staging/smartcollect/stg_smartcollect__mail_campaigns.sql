select
    id as mail_campaign_id,
    title as mail_campaign_name,
    description as mail_campaign_description,
    target as mail_campaign_target,
    runs_to as mail_campaign_end_date,
    extra_attributes as mail_campaign_extra_actributes,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

from 
    {{source('smartcollect','mail_campaigns')}}
where
    deleted_at is null and active = 1
