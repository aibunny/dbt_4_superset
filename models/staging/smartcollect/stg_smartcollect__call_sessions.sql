select
    id as call_session_id,
    call_id,
    call_type,
    {{ coalesce_to_uuid('recording_id') }},
    pbx_id,
    {{ coalesce_to_uuid('case_file_id') }},
    {{ coalesce_to_uuid('user_id') }},
    {{ coalesce_to_uuid('organization_id') }},
    campaign_id,
    session_start::timestamp as call_session_start_date_time,
    session_end::timestamp as call_session_end_date_time,
    status as call_session_status,
    caller as call_session_caller,
    callee as call_session_callee,
    dial_type as call_session_dial_type,
    session_end_reason_code as call_session_end_reason_code,
    session_end_reason_text as call_session_end_reason_text,
    disposed as call_session_is_disposed,
    disposed_action as call_session_disposed_action,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

    
from {{ source(var('source_db'), 'call_sessions')}}

where
    deleted_at is null 