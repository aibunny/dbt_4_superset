select
    id,
    title,
    subject,
    organization_id,
    target,
    product_id,
    sub_product_id,
    letter_template_id,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
    
from
    {{ source('smartcollect', 'mail_templates') }}
where
    deleted_at is null and active = 1