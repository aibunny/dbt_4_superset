with refined_call_types as (
    select
        id as call_type_id,
        title as call_type,
        description,
        created_by
    from 
        {{ref('stg_smartcollect__call_types')}}
    where active is TRUE and deleted_at is null
)

select * from refined_call_types