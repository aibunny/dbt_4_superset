select
    id as organization_type_id,
    title as organization_type,
    description as organization_type_description,
    created_by as created_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}},

    updated_by as updated_by
from
    {{ source(var('source_db'), 'organization_types') }}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}