with refined_debtors as (
    select
        id as debtor_id,
        coalesce(names,'unknown') as names,
        debtor_type,
        coalesce(gender,'unknown') as gender,
        coalesce(score,0) as score
    from 
        {{ ref('stg_smartcollect__debtors') }}
    where 
        deleted_at is null
)

select * from refined_debtors 