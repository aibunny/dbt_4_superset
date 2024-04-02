select
    id,
    title,
    subject,
    {{ coalesce_to_uuid('organization_id') }},
    target,
    {{ coalesce_to_uuid('product_id') }},
    {{ coalesce_to_uuid('sub_product_id') }},
    {{ coalesce_to_uuid('letter_template_id') }},
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

    
from
    {{ source(var('source_db'), 'mail_templates') }}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}