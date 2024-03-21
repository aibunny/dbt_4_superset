with call_types as (
    select 
        id as call_type_id,
        title as call_type,
        description as call_type_description,
        tag as call_type_tag,
        created_by,
        updated_by,
        deleted_by,
        created_at::timestamp as created_at,
        deleted_at::timestamp as deleted_at
    
    from
        {{source('smartcollect','call_types')}}
)

select * from call_types