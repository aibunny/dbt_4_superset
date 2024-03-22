select
    id as organization_type_id,
    title as organization_type_title,
    description as organization_type_description,
    created_by as created_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    updated_by as updated_by
from
    {{ source('smartcollect', 'organization_types') }}
where
    deleted_at is null and active = 1