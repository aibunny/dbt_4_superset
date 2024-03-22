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
        days_range,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

        
    from
        {{source('smartcollect', 'buckets')}}
    
    where
        deleted_at is null and active = 1
)

select * from buckets