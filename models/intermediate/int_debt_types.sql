with debt_types as (
    select 
        *
    from
        {{ ref('stg_smartcollect__debt_types')}}
    where 
        deleted_at is null
)

select * from debt_types 