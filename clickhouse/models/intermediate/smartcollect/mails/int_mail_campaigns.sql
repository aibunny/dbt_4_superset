with mail_campaigns as(
    select
        m.mail_id as mail_id,
        m.mail_subject as mail_subject,
        m.case_file_id as case_file_id,
        m.organization_id as organization_id,
        m.user_id as user_id,
        m.provider as provider,
        m.mail_template_id as mail_template_id,
        m.campaign_batch_id as campaign_batch_id,
    --    m.target as mail_target,
        m.scheduled_at as mail_scheduled_at,
        m.sent as mail_sent,
        m.send_failure_reason as mail_Send_failure_reason,
        m.sent_at as mail_sent_at,
        m.mail_created_at as mail_created_at,

        mc.mail_campaign_name as mail_campaign_name,
        mc.mail_campaign_target as mail_campaign_target,
        mc.mail_campaign_end_date as mail_campaign_end_date,
        mc.created_at as mail_campaign_created_at
    from 
        {{ref('stg_smartcollect__mails')}} m
    left join
        {{ref('stg_smartcollect__mail_campaigns')}} mc on m.mail_campaign_id = mc.mail_campaign_id

)

select * from mail_campaigns
