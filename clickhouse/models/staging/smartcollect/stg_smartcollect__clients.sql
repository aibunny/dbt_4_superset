select
    id as client_id,
    title as client_name,
    client_type_id as client_type_id,
    country_id as country_id,
    branch_id as branch_id,
    team_leader_id as team_leader_id,
    paybill,
    general_target as general_target,
    gen_commission as general_commission,
    created_by,
    updated_by,
    created_at as created_at,
    {{coalesce_to_timestamp('updated_at')}}

from 
    {{source('smartcollect','clients')}}

where
    deleted_at is null and active = {{ get_active_value(target.type) }}