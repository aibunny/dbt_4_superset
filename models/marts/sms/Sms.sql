{{
    config(
        alias = 'Sms'
    )
}}

with sms_mart as (
    select
        *
    from
        {{ref('int_sms')}}
    
    union all
    
    select
        *
    from
        {{ref('int_new_sms')}}
)

select 
    distinct
    *
from sms_mart