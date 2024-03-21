with refined_notes as (
    select
        id as note_id,
        contents,
        update_type,
        case_file_id as cfid,
        contact_status_id,
        call_type_id,
        created_by,
        created_at
    from 
        {{ ref('stg_smartcollect__notes')}}
    
    where deleted_at is null
)

select * from refined_notes