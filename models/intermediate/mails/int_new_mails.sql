{{
    config(
        materialized = 'view'
    )
}}

with mail_campaigns as(
    select
        m.mail_id as mail_id,
        
        m.case_file_id as case_file_id,
        m.organization_id as organization_id,
        m.user_id as user_id,
        m.mail_subject as mail_subject,
        m.provider as provider,
        m.mail_template_id as mail_template_id,
        m.campaign_batch_id as campaign_batch_id,
        u.user_name as user,
        o.organization_name as organization,
        o.country_name as country,
        o.organization_is_primary as organization_is_primary,
    --    m.target as mail_target,
        m.scheduled_at as mail_scheduled_at,
        m.sent as mail_sent,
        m.send_failure_reason as mail_Send_failure_reason,
        mc.mail_campaign_name as mail_campaign_name,

        mc.mail_campaign_target as mail_campaign_target,
        m.sent_at as mail_sent_at,
        m.mail_created_at as mail_created_at,        
        mc.mail_campaign_end_date as mail_campaign_end_date,
        mc.created_at as mail_campaign_created_at
    from 
        {{ref('stg_smartcollect__mails')}} m
    left join
        {{ref('stg_smartcollect__mail_campaigns')}} mc 
        on m.mail_campaign_id = mc.mail_campaign_id
    
    left join 
        {{ref('ref_organization')}} o
        on m.organization_id = o.organization_id
    left join 
        {{ref('stg_smartcollect__users')}} u
        on u.user_id = u.user_id
    
    where m.mail_created_at >= {{runtime( run_started_at, target.type)}}
)

select * from mail_campaigns
