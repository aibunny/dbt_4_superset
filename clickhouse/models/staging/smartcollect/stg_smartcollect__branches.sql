--- branches

with branches as(
    select
        id as branch_id,
        title as branch_name,
        branch_manager,
        organization_id,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}
    
    from
        {{source('smartcollect', 'branches')}}
    where
    deleted_at is null and active = {{ get_active_value(target.type) }}
)

select *
from branches
