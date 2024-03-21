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
        deleted_by,
        created_at::timestamp as created_at,
        updated_at::timestamp as updated_at,
        deleted_at::timestamp as deleted_at
    
    from
        {{source('smartcollect', 'branches')}}
)

select *
from branches