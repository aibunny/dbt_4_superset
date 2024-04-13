{{
    config(
        alias = 'Payments'
    )
}}
with payment_mart as (
    select 
        *,
        row_number() over (partition by payment_id order by updated_at desc) as rn
    
    from 

    (
        select 
            *
        from    
            {{ ref('int_payments')}}
        
        union all

        select
            *
        from
            {{ ref('int_new_payments')}}
    )
)

select 
    distinct
    *
from payment_mart