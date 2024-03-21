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
    deleted_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at                                                           

from {{ source('smartcollect','client_contacts')}}
