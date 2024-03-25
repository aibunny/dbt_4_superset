--- contact_types

with contact_types as (
    select
        id as contact_type_id,
        upper(title) as contact_type_name,
        description as contact_type_description,
        tag as contact_type_tag,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

    from
        {{source('smartcollect', 'contact_types')}}
    where
        deleted_at is null and active = 1
)
select * from contact_types