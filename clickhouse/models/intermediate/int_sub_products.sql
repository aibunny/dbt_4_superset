with refined_sub_products as (
    select 
        id as sub_product_id,
        product_id,
        title as sub_product,
        description as sub_product_description
    from
        {{ ref('stg_smartcollect__sub_products')}}
    where active = 1 and deleted_at is null
)

select * from refined_sub_products