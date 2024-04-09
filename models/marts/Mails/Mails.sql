{{
    config(
        materialized = 'view'
    )
}}

with mails_mart as (
    select 
        *
    from
        {{ref('int_mails')}}
    
    union all

    select 
        *
    from
        {{ref('int_new_mails')}}
)

select 
    distinct
    *
from mails_mart