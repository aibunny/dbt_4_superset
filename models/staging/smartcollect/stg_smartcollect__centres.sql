select
    id as centre_id,
    title as centre,
    branch_id,
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}
from 
    {{ source(var('source_db'), 'centres')}}
where
    deleted_at is null