with refined_contact_types as (
    select
        id as contact_type_id,
        title as contact_type,
        description
    from 
        {{ ref('stg_smartcollect__contact_types')}}
    where 
        deleted_at is null and active = 1
)

select * from refined_contact_types 