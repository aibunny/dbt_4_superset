with refined_sub_products as (
    select 
        id as sub_product_id,
        product_id,
        title,
        description,
        active,
        created_at
    from
        {{ ref('stg_smartcollect__sub_products')}}
    where active is TRUE and deleted_at is null
)

select * from refined_sub_products