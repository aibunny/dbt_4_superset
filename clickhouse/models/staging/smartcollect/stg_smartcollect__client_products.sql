select
    client_id,
    product_id,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at

from {{source('smartcollect','client_products')}}
