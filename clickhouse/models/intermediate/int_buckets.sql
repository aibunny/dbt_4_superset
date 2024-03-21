with buckets as (
    select
        id as bucket_id,
        title as bucket,
        description,
        product_id,
        sub_product_id,
        lower_limit,
        upper_limit,
        days_range    
    from 
        {{ ref('stg_smartcollect__buckets') }}
    where 
        deleted_at is null and active = 1
)

select * from buckets 