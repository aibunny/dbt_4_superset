with refined_dispute_reasons as (
    select
        id as dispute_reason_id,
        title as dispute_reason,
        description
    from
        {{ ref('stg_smartcollect__dispute_reasons')}}
    where 
        deleted_at is null and active = 1
)

select * from refined_dispute_reasons 