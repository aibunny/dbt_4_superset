with collection_stages as (
    select
        id as collection_stage_id,
        title as collection_stage_name,
        description as collection_stage_description,
        tag as collection_stage_tag,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

        
    from
        {{ source(var('source_db'), 'collection_stages') }}
    where
    deleted_at is null and active = {{ get_active_value(target.type) }}

)

select * 
from 
    collection_stages 

