select
    id as call_campaign_id
    organization_id,
    title as call_campaign_name,
    description as call_campaign_description,
    dialing_extension as call_campaign_dialling_extension,
    dial_mode as call_campaign_dial_mode,
    configurations as call_campaign_configurations,
    runs_from::timestamp as call_campaign_start_date_time,
    runs_to::timestamp as call_campaign_end_date_time,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
    
from {{ source('smartcollect', 'call_campaigns')}}

where
    deleted_at is null and active = 1

