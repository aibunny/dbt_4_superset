select
    id as collection_strategy_id,
    title as collection_strategy,
    description as collection_strategy_description,
    {{ coalesce_to_uuid('organization_id') }},
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from 
    {{source(var('source_db'),'collection_strategies')}}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}
