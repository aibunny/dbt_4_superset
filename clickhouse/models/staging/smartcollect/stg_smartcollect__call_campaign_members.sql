select
    call_campaign_id,
    {{ coalesce_to_uuid('organization_id') }},
    {{ coalesce_to_uuid('user_id') }},
    is_paused
from
    {{ source('smartcollect', 'call_campaign_members') }}