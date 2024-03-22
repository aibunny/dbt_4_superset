with currencies as (
    select 
        id as currency_id,
        title as currency,
        symbol as currency_symbol
    from 
        {{ref('stg_smartcollect__currencies')}}
    where 
        deleted_at is null and active = 1
)

select * from currencies