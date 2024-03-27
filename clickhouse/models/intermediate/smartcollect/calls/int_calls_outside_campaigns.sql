-- This are calls outside call campaigns and their ratings

with calls_outside_campaigns as(
    select
        c.call_id as call_id,
        c.case_file_id as case_file_id,
        c.user_id as user_id,
        c.organization_id as organization_id,
        c.call_from as call_from,
        c.call_to as call_to,
        (c.call_duration_in_seconds - c.call_talk_time_in_seconds) as call_ring_time_seconds,
        c.call_talk_time_in_seconds as call_talk_time_in_seconds,
        c.source_trunk_name as source_trunk_name,
        c.destination_trunk_name as destination_trunk_name,
        c.call_status as call_status,
        c.call_type as call_type,
        c.agent_ring_time as agent_ring_time,
        c.created_at as call_made_at,
        u.user_name as user,
        o.organization_name as organization,
        cr.call_rating as call_rating   
    
    from 
        {{ref('stg_smartcollect__calls')}} c
    left join  
        {{ref('stg_smartcollect__call_callibrations')}} cr
        on c.call_id = cr.call_id
    left join
        {{ ref('stg_smartcollect__organizations')}} o 
        on c.organization_id = o.organization_id
    left join
        {{ ref('stg_smartcollect__users')}} u
        on c.user_id = u.user_id
    where
        c.call_campaign_id = {{default_uuid(target.type)}}
)   

select 
    *
from
    calls_outside_campaigns