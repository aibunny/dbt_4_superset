select
    id as collection_strategy_id,
    title as collection_strategy,
    description as collection_strategy_description,
    organization_id,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
from 
    {{source('smartcollect','collection_strategies')}}
where
    deleted_at is null and active = 1
