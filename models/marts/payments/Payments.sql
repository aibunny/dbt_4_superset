{{
    config(
        alias = 'Payments'
    )
}}
with payment_mart as (
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

select 
    distinct
    *
from payment_mart