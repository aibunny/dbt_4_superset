--- branches

with branches as(
    select
        id as branch_id,
        title as branch_name,
        branch_manager,
        organization_id,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at
    
    from
        {{source('smartcollect', 'branches')}}
    where
    deleted_at is null and active = 1
)

select *
from branches
