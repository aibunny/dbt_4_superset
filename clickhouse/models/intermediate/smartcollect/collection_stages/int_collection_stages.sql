with refined_stages as (
    select
        cs.collection_stage_id as collection_stage_id,
        csb.collection_sub_stage_id as collection_sub_stage_id,
        cs.collection_stage_name as collection_stage_name, 
        csb.collection_sub_stage_name as collection_sub_stage_name,
        cs.created_at as created_at
    
    from 
        {{ref('stg_smartcollect__collection_stages')}} cs
    left join 
        {{ref('stg_smartcollect__collection_sub_stages')}} csb on cs.collection_stage_id = csb.collection_stage_id
)

select * from refined_stages