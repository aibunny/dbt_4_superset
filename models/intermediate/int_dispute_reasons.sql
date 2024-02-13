with refined_dispute_reasons as (
    select
        id as dispute_reason_id,
        title,
        description
    from
        {{ ref('stg_smartcollect__dispute_reasons')}}
    where 
        deleted_at is null and active is TRUE
)

select * from refined_dispute_reasons 