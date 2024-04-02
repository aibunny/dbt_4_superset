select
    client_id,
    product_id,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}


from 
    {{source(var('source_db'),'client_products')}}
where
    deleted_at is null