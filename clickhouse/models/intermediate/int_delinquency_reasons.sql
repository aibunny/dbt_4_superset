with refined_delinquency_reason as (
    select
        id as delinquency_reason_id,
        title as delinquency_reason,
        description        
    from 
        {{ ref("stg_smartcollect__delinquency_reasons") }}
    where 
        deleted_at is null and active = 1
)

select * from refined_delinquency_reason 