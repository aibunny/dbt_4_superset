--- contact_types

with contact_types as (
    select
        id as contact_type_id,
        title as contact_type_name,
        description as contact_type_description,
        tag as contact_type_tag,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

    from
        {{source(var('source_db'), 'contact_types')}}
    where
        deleted_at is null and active = {{ get_active_value(target.type) }}
)
select * from contact_types