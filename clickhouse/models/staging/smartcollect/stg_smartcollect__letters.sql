select
    id as letter_id,
    title as letter_name,
    description as letter_description,
    {{ coalesce_to_uuid('case_file_id') }},
    file_name,
    file_ext,
    {{ coalesce_to_uuid('organization_id') }},
    file_type,
    {{ coalesce_to_uuid('template_id') }},
    storage_provider_id,
    storage_provider,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

from
    {{ source('smartcollect', 'letters') }}
where 
    deleted_at is null and active =1