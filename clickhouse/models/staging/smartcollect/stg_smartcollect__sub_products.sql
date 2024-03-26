with sub_products as (
    select 
        id as sub_product_id,
        product_id as product_id,
        upper(title) as sub_product_name,
        description as description,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

    from 
        {{source('smartcollect','sub_products')}}
    where
        deleted_at is null and active = 1
)

select * from sub_products