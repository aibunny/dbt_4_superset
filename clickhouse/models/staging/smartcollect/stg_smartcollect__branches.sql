--- branches

with branches as(
    select
        id as branch_id,
        title as branch,
        active as is_active,
        branch_manager,
        organization_id,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        updated_at::timestamp as updated_at
    
    from
        {{source('smartcollect', 'branches')}}
)

select *
from branches
where
    deleted_at is null and is_active = 1