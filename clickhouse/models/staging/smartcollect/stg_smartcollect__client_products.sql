select
    client_id,
    product_id,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at


from 
    {{source('smartcollect','client_products')}}
where
    deleted_at is null