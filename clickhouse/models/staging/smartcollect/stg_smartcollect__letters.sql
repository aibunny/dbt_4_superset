select
    id as letter_id,
    title as letter_name,
    description as letter_description,
    case_file_id,
    file_name,
    file_ext,
    organization_id,
    file_type,
    template_id,
    storage_provider_id,
    storage_provider,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
from
    {{ source('smartcollect', 'letters') }}
where 
    deleted_at is null and active =1