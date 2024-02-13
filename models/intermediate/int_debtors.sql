with refined_debtors as (
    select
        id as debtor_id,
        names,
        debtor_type,
        gender,
        score
    from 
        {{ ref('stg_smartcollect__debtors') }}
    where 
        deleted_at is null
)

select * from refined_debtors 