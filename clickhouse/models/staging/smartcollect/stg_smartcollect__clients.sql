select
    id as client_id,
    title as client,
    client_type_id,
    country_id,
    branch_id,
    team_leader_id,
    paybill,
    general_target,
    gen_commission,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
from 
    {{source('smartcollect','clients')}}

where
    deleted_at is null and active = 1