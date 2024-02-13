with refined_contact_types as (
    select
        id as contact_type_id,
        title,
        description,
        created_by,
        created_at
    from 
        {{ ref('stg_smartcollect__contact_types')}}
    where 
        deleted_at is null and active is True
)

select * from refined_contact_types 