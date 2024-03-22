with refined_collection_sub_stages as (
    select
        id as collection_sub_stage_id,
        collection_stage_id,
        title as collection_sub_stage,
        description as collection_sub_stage_description
    from 
        {{ref('stg_smartcollect__collection_sub_stages')}}
    where
        active = 1 and deleted_at is null
)

select * from refined_collection_sub_stages