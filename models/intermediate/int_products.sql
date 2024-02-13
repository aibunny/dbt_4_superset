with refined_products as (
    select
        id as product_id,
        title,
        description,
        created_at
    from 
        {{ ref('stg_smartcollect__products')}}
    where 
        deleted_at is null
)

select * from refined_products 