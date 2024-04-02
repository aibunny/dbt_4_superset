select
    id as mail_id,    
    {{ coalesce_to_uuid('case_file_id') }},
    {{ coalesce_to_uuid('organization_id') }},
    {{ coalesce_to_uuid('user_id') }},
    {{ coalesce_to_uuid('smtp_account_id') }},     
    {{ coalesce_to_uuid('mail_template_id') }},    
    {{ coalesce_to_uuid('mail_campaign_id') }},
    {{ coalesce_to_uuid('campaign_batch_id') }},
    subject as mail_subject,
    email as mail_email,
    cc as mail_cc,
    bcc as mail_bcc,
    target,
    provider,  
    batch_no,
    attachment_path,
    case when scheduled_at is not null then scheduled_at::timestamp else scheduled_at end as scheduled_at,
    sent,
    send_failure_reason,
    sent_at::timestamp as sent_at,
    created_by as mail_created_by,
    updated_by as mail_updated_by,
    created_at::timestamp as mail_created_at,
    updated_at::timestamp as mail_updated_at
from
    {{ source(var('source_db'), 'mails') }}
where
    deleted_at is null
