with collection_sub_stages as (
    select
        id as collection_sub_stage_id,
        title as collection_sub_stage_name,
        description as collection_sub_stage_description,
        collection_stage_id,
        created_by,
        updated_by,
        created_at,
        updated_at,
        tag
    from
        {{ source('smartcollect', 'collection_sub_stages') }}
    where
        deleted_at is null and active = 1
)

select * from collection_sub_stages
