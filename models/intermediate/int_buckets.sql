with buckets as (
    select
        id as bucket_id,
        title,
        description,
        product_id,
        sub_product_id,
        lower_limit,
        upper_limit,
        days_range,
        created_at
    
    from 
        {{ ref('stg_smartcollect__buckets') }}
    where 
        deleted_at is null and active is TRUE
)

select * from buckets 