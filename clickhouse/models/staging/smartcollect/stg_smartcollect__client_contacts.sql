select
    id as client_contact_id,
    title as client_contact,
    designation as client_contact_designation,
    phone,
    email,
    branch as client_contact_branch,
    client_id,
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}
                                                        

from 
    {{ source(var('source_db'),'client_contacts')}}
where
    deleted_at is null
