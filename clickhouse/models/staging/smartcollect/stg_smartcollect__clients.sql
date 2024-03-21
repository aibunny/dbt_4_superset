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
    active as client_is_active,
    created_by,
    updated_by,
    deleted_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at
from {{source('smartcollect','clients')}}