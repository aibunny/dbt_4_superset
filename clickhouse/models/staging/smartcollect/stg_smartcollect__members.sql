select
    call_campaign_id,
    user_id,
    organization_id,
    is_pause as call_campaign_member_is_paused
from
    {{ source('smartcollect', 'call_campaign_members')}}
