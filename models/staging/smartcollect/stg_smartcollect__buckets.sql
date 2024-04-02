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
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

        
    from
        {{source(var('source_db'), 'buckets')}}
    
    where
        deleted_at is null and active = {{ get_active_value(target.type) }}
)

select * from buckets