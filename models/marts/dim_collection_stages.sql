with dim_collection_stage as (
    select
        cs.collection_stage_id,
        cs.collection_stage_name,
        cs.collection_stage_description,
        css.collection_sub_stage_id,
        css.collection_sub_stage_name,
        css.collection_sub_stage_description
    from 
        {{ref('int_collection_stages')}} cs
    left join
        {{ref('int_collection_sub_stages')}} css on cs.collection_stage_id = css.collection_stage_id
)

select * from dim_collection_stage 