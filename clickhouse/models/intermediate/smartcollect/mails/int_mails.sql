with mails as(
    select
        m.mail_id as mail_id,
        m.mail_subject as mail_subject,
        m.case_file_id as case_file_id,
        m.organization_id as organization_id,
        m.user_id as user_id,
        m.provider as provider,
        m.mail_template_id as mail_template_id,
        m.campaign_batch_id as campaign_batch_id,
        m.target as mail_target,
        m.scheduled_at as mail_scheduled_at,
        m.sent as mail_sent,
        m.send_failure_reason as mail_Send_failure_reason,
        m.sent_at as mail_sent_at,
        m.mail_created_at as mail_created_at
    from 
        {{ref('stg_smartcollect__mails')}} m
    where mail_campaign_id is null
)

select * from mails