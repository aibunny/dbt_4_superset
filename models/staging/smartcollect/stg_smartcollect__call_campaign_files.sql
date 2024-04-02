select
    id as call_campaign_file_id,
    case_file_id,
    campaign_type as call_campaign_type,
    call_campaign_id,
    dial_mode as call_campaign_dial_mode,
    batch_id as call_campaign_file_batch_id,
    queue_position as call_campaign_file_queue_position,
    done as call_campaign_file_is_done,
    status as call_campaign_file_status,
    user_id,
    is_locked call_campaign_file_is_locked

from    
    {{source(var('source_db'), 'call_campaign_files')}}



