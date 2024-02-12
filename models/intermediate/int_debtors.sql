with refined_debtors as (
    select
        id as debtor_id,
        names,
        debtor_type,
        gender,
        score,
        created_at,
        created_by,
        deleted_at
    from {{ ref('stg_smartcollect__debtors') }}
)

select * from refined_debtors where deleted_at is null