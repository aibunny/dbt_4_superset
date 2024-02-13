with refined_delinquency_reason as (
    select
        id as delinquency_id,
        title,
        description        
    from 
        {{ ref("stg_smartcollect__delinquency_reasons") }}
    where 
        deleted_at is null and active = TRUE
)

select * from refined_delinquency_reason 