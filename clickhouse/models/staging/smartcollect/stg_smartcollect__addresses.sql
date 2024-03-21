select
    id as address_id,
    address,
    type as address_type,
    notes as address_notes,
    addressable_id,
    addressable_type,
    created_by::timestamp as created_by,
    updated_by::timestamp as updated_by,
    deleted_by::timestamp as deleted_by,
    created_at::timestamp as created_at,
    deleted_at::timestamp as deleted_at
    
from {{ source('smartcollect', 'addresses')}}

