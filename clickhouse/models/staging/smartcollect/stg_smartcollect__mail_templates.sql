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
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

    
from
    {{ source('smartcollect', 'mail_templates') }}
where
    deleted_at is null and active = 1