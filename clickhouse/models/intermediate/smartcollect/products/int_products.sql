with refined_products as (
    select
        p.product_id as product_id,
        sp.sub_product_id as sub_product_id,
        p.product_name as product_name,
        sp.sub_product_name,
        p.created_at as created_at
    from 
        {{ref('stg_smartcollect__products')}} p
    left join
        {{ ref('stg_smartcollect__sub_products')}} sp on p.product_id = sp.sub_product_id
)

select * from refined_products