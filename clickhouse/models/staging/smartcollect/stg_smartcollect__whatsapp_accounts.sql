select
    id as whatsapp_account_id,
    title as whatsapp_account_name,
    description as whatsapp_account_description,
    organization_id,
    whatsapp_phone_number_id,
    whatsapp_phone_number,
    business_account_id,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

    
from
    {{ source('smartcollect', 'whatsapp_accounts') }}
where
    deleted_at is null and active = 1
