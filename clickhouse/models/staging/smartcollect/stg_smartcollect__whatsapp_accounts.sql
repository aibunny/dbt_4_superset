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
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

    
from
    {{ source('smartcollect', 'whatsapp_accounts') }}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}
