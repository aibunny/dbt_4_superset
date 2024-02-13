with sub_products as (
    select * 
    from {{source('smartcollect','sub_products')}}
)

select * from sub_products