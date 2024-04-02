with call_types as (
    select 
        id as call_type_id,
        title as call_type,
        description as call_type_description,
        tag as call_type_tag,
        created_by,
        updated_by,
        created_at
    
    from
        {{source(var('source_db'),'call_types')}}

    where
        deleted_at is null
)

select * from call_types