select
    id as whatsapp_campaign_id,
    title as whatsapp_campaign_name,
    description as whatsapp_campaign_description,
    target as whatsapp_campaign_target,
    runs_from,
    runs_to,
    {{ coalesce_to_uuid('organization_id') }},
    extra_attributes,
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from
    {{ source('smartcollect', 'whatsapp_campaigns') }}
where 
    deleted_at is null and active = {{ get_active_value(target.type) }}