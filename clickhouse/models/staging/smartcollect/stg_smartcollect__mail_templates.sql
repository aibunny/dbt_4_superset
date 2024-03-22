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
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

    
from
    {{ source('smartcollect', 'mail_templates') }}
where
    deleted_at is null and active = 1