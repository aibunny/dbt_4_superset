with refined_delinquency_reason as (
    select
        id as delinquency_id,
        title,
        description,
        active,
        created_at,
        deleted_at
    from {{ ref("stg_smartcollect__delinquency_reasons") }}
)

select * from refined_delinquency_reason where deleted_at is null and active = TRUE