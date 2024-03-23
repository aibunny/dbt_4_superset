-- calls

with calls as (
    select
        id as call_id,
        organization_id,
        case_file_id,
        call_campaign_id,
        user_id,
        time_start as call_start_date_time,
        call_from,
        call_to,
        call_duration as call_duration_in_seconds,
        talk_duration as call_talk_time_in_seconds,
        src_trunk_name as source_trunk_name,
        dst_trunk_name as destination_trunk_name, --gsm provider
        pin_code,
        status as call_status,
        type as call_type,
        recording,
        did_number,
        agent_ring_time,
        created_at::timestamp as created_at
    from
        {{ source('smartcollect', 'calls')}}
    )

select * from calls