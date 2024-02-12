with branches as (
    select 
        id as branch_id,
        title,
        active,
        branch_manager,
        created_at,
        deleted_at
    from {{ ref("stg_smartcollect__branches") }}
)

select * from branches where deleted_at is null