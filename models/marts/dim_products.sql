with dim_products as (
    select
        p.product_id as product_id,
        p.title as product_name,
        p.description as product_description,
        p.created_at as product_created_date,
        sp.sub_product_id as sub_product_id,
        sp.title as sub_product_name,
        sp.description as sub_product_description,
        sp.created_at as sub_product_created_date
    from
        {{ ref('int_products')}} p
    inner join {{ref('int_sub_products')}} sp on p.product_id = sp.product_id
)

select * from dim_products