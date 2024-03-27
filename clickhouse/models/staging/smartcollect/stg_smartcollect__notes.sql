select
    id as note_id,
    contents as contents,
    upper(update_type) as update_type,
    case_file_id,
    contact_status_id,
    call_type_id,
    attachment_type,
    attachment_id,
    object_type,
    object_type_id,
    created_by ,
    updated_by,
    created_at,
    {{coalesce_to_timestamp('updated_at')}}

from
    {{ source('smartcollect', 'notes') }}
where
    deleted_at is null 

