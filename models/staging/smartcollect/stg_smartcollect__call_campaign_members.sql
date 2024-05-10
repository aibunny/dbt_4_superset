select
    call_campaign_id,
    {{ coalesce_to_uuid('organization_id') }},
    {{ coalesce_to_uuid('user_id') }}
from
    {{ source(var('source_db'), 'call_campaign_members') }}