--- products

with products as (
    select
        id as product_id,
        title as product_name,
        description as description,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}
    from
    {{ source(var('source_db'), 'products')}}
)

select * from products