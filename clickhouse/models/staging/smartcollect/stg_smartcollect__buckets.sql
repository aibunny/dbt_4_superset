--- buckets

with buckets as(
    select
        id as bucket_id,
        title as bucket_name,
        description as bucket_description,
        product_id,
        sub_product_id,
        coalesce(lower_limit, 0) as lower_limit,
        coalesce(upper_limit,0) as upper_limit,
        active as is_active,
        days_range,
        created_by::timestamp as created_by,
        updated_by::timestamp as updated_by,
        deleted_by::timestamp as deleted_by,
        created_at::timestamp as created_at,
        updated_at::timestamp as updated_at,
        deleted_at::timestamp as deleted_at
        
    from
        {{source('smartcollect', 'buckets')}}
)

select * from buckets