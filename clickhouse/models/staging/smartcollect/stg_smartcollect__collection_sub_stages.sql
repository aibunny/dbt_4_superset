with collection_sub_stages as (
    select
        id as collection_sub_stage_id,
        title as collection_sub_stage_name,
        description as collection_sub_stage_description,
        tag,
        collection_stage_id,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}
    from
        {{ source('smartcollect', 'collection_sub_stages') }}
    where
        deleted_at is null and active = {{ get_active_value(target.type) }}
)

select * from collection_sub_stages
