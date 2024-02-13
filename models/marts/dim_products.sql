with dim_products as (
    select
        p.product_id,
        p.product_name,
        p.product_description,
        sp.sub_product_id,
        sp.sub_product_name,
        sp.sub_product_description
    from
        {{ ref('int_products')}} p
    left join {{ref('int_sub_products')}} sp on p.product_id = sp.product_id
)

select * from dim_products