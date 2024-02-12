with buckets as (
    select
        id as bucket_id,
        title,
        description,
        product_id,
        sub_product_id,
        lower_limit,
        upper_limit,
        active,
        days_range,
        created_at,
        deleted_at
    
    from {{ ref('stg_smartcollect__buckets') }}

)

select * from buckets where deleted_at is null 