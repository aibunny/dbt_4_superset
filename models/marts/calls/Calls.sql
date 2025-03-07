{{
    config(
        alias='Calls'
    )
}}

with calls_mart as (

    select
        *
    from
        {{ref('int_calls')}}
    
    union all

    select
        *
    from
        {{ref('int_new_calls')}}
)

select 
    distinct
    *
from calls_mart