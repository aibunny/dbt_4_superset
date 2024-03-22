select
    id as call_campaign_member_session_id,
    call_campaign_id,
    user_id,
    is_paused as call_campaign_member_session_is_paused,
    status as call_campaign_member_session_status,
    extra_attributes as call_campaign_member_session_extra_attributes,
    created_at::timestamp as created_at
from
    {{source('smartcollect', 'call_campaign_member_sessions')}}