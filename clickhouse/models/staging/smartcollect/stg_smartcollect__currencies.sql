with currencies as (
    select 
        id as currency_id,
        title as currency_name,
        symbol as currency_symbol,
        created_at,
        created_by,
        updated_by,
        {{ coalesce_to_timestamp('updated_at')}}
    from 
        {{source('smartcollect','currencies')}}
    where
        deleted_at is null and active = {{ get_active_value(target.type) }}
)

select * from currencies