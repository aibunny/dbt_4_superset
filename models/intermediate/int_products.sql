with refined_products as (
    select
        id as product_id,
        title as product_name,
        description as product_description
    from 
        {{ ref('stg_smartcollect__products')}}
    where 
        deleted_at is null
)

select * from refined_products 