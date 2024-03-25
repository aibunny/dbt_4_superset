select
    id as organization_type_id,
    upper(title) as organization_type_title,
    description as organization_type_description,
    created_by as created_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at,

    updated_by as updated_by
from
    {{ source('smartcollect', 'organization_types') }}
where
    deleted_at is null and active = 1