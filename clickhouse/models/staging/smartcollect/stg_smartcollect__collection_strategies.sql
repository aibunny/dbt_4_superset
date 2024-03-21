select
    id as collection_strategy_id,
    title as collection_strategy,
    description as collection_strategy_description,
    active as collection_strategy_is_active,
    organization_id,
    created_by,
    updated_by,
    deleted_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at
from 
    {{source('smartcollect','collection_strategies')}}
