with branches as (
    select 
        id as branch_id,
        title as branch_name,
        active,
        branch_manager
    from
        {{ ref("stg_smartcollect__branches") }}
    where 
        deleted_at is null
)

select * from branches 