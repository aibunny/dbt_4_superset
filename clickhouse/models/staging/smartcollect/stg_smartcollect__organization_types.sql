select
    id as organization_type_id,
    title as organization_type_title,
    description as organization_type_description,
    active as organization_type_active,
    created_by as created_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    updated_by as updated_by,
    deleted_at::timestamp as deleted_at,
    deleted_by as deleted_by
from
    {{ source('smartcollect', 'organization_types') }}