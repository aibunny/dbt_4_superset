with debt_types as (
    select 
        id as debt_type_id,
        title as debt_type,
        description as debt_type_description
    from
        {{ ref('stg_smartcollect__debt_types')}}
    where 
        deleted_at is null and active = 1
)

select * from debt_types 