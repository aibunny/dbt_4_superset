with refined_products as (
    select
        id as product_id,
        ref_id,
        title,
        description,
        active,
        external_id,
        created_at,
        deleted_at
    from {{ ref('stg_smartcollect__products')}}
)

select * from refined_products where deleted_at is null