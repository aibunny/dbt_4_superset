with collection_stages as (
    select
        id as collection_stage_id,
        upper(title) as collection_stage_name,
        description as collection_stage_description,
        tag as collection_stage_tag,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

        
    from
        {{ source('smartcollect', 'collection_stages') }}
    where
    deleted_at is null and active = 1

)

select * 
from 
    collection_stages 

