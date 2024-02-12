with refined_calls as (
    select
        id as call_id,
        organization_id,
        case_file_id as cfid,
        call_campaign_id,
        user_id,
        pbx_sn,
        external_id,
        time_start,
        call_from,
        call_duration,
        talk_duration,
        src_trunk_name,
        dst_trunk_name,
        status,
        type,
        did_number,
        agent_ring_time,
        created_at
    from {{ ref('stg_smartcollect__calls')}}
)

select * from refined_calls 