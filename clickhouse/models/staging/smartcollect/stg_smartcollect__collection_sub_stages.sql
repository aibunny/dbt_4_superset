with collection_sub_stages as (
    select
        id as collection_sub_stage_id,
        upper(title) as collection_sub_stage_name,
        description as collection_sub_stage_description,
        tag,
        collection_stage_id,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at
    from
        {{ source('smartcollect', 'collection_sub_stages') }}
    where
        deleted_at is null and active = 1
)

select * from collection_sub_stages
