select
    id as campaign_batch_id,
    organization_id,
    batch_no as call_campaign_no,
    status as campaign_batch_status,
    campaignable_id,
    campaignable_type,
    templatable_id,
    templatable_type,
    batch_process_id,
    send_time::timestamp as campaign_send_time,
    created_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

from
    {{ source('smartcollect', 'campaign_batches')}}