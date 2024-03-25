select
    id as campaign_batch_id,
    {{ coalesce_to_uuid('organization_id') }},
    batch_no as call_campaign_no,
    status as campaign_batch_status,
    {{ coalesce_to_uuid('campaignable_id') }},
    campaignable_type,
    {{ coalesce_to_uuid('templatable_id') }},
    templatable_type,
    batch_process_id,
    send_time::timestamp as campaign_send_time,
    created_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

from
    {{ source('smartcollect', 'campaign_batches')}}