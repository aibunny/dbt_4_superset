with refined_collection_stage as (
    select 
        id as collection_stage_id,
        title as collection_stage,
        description as collection_stage_description
    from 
        {{ref('stg_smartcollect__collection_stages')}}
    where 
        deleted_at is null and active is TRUE
)

select * from refined_collection_stage