select
    id as mail_campaign_id,
    title as mail_campaign_name,
    description as mail_campaign_description,
    target as mail_campaign_target,
    runs_to as mail_campaign_end_date,
    extra_attributes as mail_campaign_extra_actributes,
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from 
    {{source(var('source_db'),'mail_campaigns')}}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}
