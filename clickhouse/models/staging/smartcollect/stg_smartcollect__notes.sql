select
    id as note_id,
    contents as note_contents,
    update_type as note_update_type,
    case_file_id,
    contact_status_id,
    call_type_id,
    attachment_type,
    attachment_id,
    object_type,
    object_type_id,
    created_by as note_created_by,
    updated_by as note_updated_by,
    created_at::timestamp as note_created_at,
    updated_at::timestamp as note_updated_at

from
    {{ source('smartcollect', 'notes') }}
where
    deleted_at is null 

