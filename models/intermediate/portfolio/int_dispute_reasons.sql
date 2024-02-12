with refined_dispute_reasons as (
    select
        id as dispute_reason_id,
        title,
        description,
        active,
        created_at,
        created_by,
        deleted_at
    from {{ ref('stg_smartcollect__dispute_reasons')}}
)

select * from refined_dispute_reasons where deleted_at is null and active is TRUE