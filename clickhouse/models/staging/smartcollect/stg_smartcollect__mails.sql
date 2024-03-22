select
    id as mail_id,
    subject as mail_subject,
    email as mail_email,
    cc as mail_cc,
    bcc as mail_bcc,
    case_file_id,
    organization_id,
    user_id,
    smtp_account_id,
    external_id,
    provider,
    mail_template_id,
    mail_campaign_id,
    campaign_batch_id,
    target,
    batch_no,
    attachment_path,
    scheduled_at::timestamp as scheduled_at,
    sent,
    send_failure_reason,
    sent_at::timestamp as sent_at,
    created_by as mail_created_by,
    updated_by as mail_updated_by,
    created_at::timestamp as mail_created_at,
    updated_at::timestamp as mail_updated_at
from
    {{ source('smartcollect', 'mails') }}
where
    deleted_at is null
