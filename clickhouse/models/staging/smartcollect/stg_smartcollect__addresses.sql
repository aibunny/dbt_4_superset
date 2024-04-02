select
    id as address_id,
    address,
    type as address_type,
    notes as address_notes,
    addressable_id,
    addressable_type,
    created_by,
    updated_by,
    created_at
    
from {{ source(var('source_db'), 'addresses')}}

where
    deleted_at is null

