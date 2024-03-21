select
    id as call_campaign_file_id,
    case_file_id,
    call_campaign_type,
    campaign_id as call_campaign_type,
    dial_mode as call_campaign_dial_mode,
    batch_id as call_campaign_file_batch_id,
    queue_position as call_campaign_file_queue_position,
    is_done as call_campaign_file_is_done,
    status as call_campaign_file_status,
    user_id,
    is_locked call_campaign_file_is_locked

from    
    {{source('smartcollect', 'stg_smartcollect__call_campaign_files')}}