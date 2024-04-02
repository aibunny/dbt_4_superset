select
    id as client_type_id,
    title as client_type,
    description as client_type_description,
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from 
    {{source(var('source_db'),'client_types')}}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}