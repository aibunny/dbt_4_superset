with branches as (
    select 
        id as branch_id,
        title as branch,
        active,
        branch_manager
    from
        {{ ref("stg_smartcollect__branches") }}
    where 
        deleted_at is null and active = 1 
)

select * from branches 