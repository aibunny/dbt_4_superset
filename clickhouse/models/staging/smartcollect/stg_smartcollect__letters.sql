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
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from
    {{ source('smartcollect', 'letters') }}
where 
    deleted_at is null and active = {{get_active_value(target.type)}}