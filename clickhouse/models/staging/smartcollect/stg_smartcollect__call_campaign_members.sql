select
    call_campaign_id,
    organization_id,
    user_id,
    is_paused
from
    {{ source('smartcollect', 'call_campaign_members') }}