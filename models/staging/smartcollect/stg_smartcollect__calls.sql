-- calls

with calls as (
    select
        id as call_id,
        {{ coalesce_to_uuid('organization_id') }},
        {{ coalesce_to_uuid('case_file_id') }},
        {{ coalesce_to_uuid('call_campaign_id') }},
        {{ coalesce_to_uuid('user_id') }},
        time_start as call_start_date_time,
        call_from,
        call_to,
        call_duration as call_duration_in_seconds,
        talk_duration as call_talk_time_in_seconds,
        coalesce(src_trunk_name,'Unknown') as source_trunk_name,
        coalesce(dst_trunk_name,'Unknown') as destination_trunk_name, --gsm provider
        pin_code,
        status as call_status,
        type as call_type,
        recording,
        did_number,
        coalesce(agent_ring_time,0) as agent_ring_time,
        created_at
    from
        {{ source(var('source_db'), 'calls')}}
    )

select * from calls