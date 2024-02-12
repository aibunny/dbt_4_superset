with debt_types as (
    select 
        *
    from
        {{ ref('stg_smartcollect__debt_types')}}
)

select * from debt_types where deleted_at is null