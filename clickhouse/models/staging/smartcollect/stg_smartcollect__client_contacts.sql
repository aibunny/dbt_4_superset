select
    id as client_contact_id,
    upper(title) as client_contact,
    designation as client_contact_designation,
    phone,
    email,
    branch as client_contact_branch,
    client_id,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at
                                                        

from 
    {{ source('smartcollect','client_contacts')}}
where
    deleted_at is null
