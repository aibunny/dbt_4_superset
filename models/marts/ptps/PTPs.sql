{{
    config(
        alias = 'PTPs'
    )
}}

with ptp_mart as (
    select
        *
    from
        {{ref('int_ptps')}}
    
    union all

    select   
        *
    from
        {{ref('int_new_ptps')}}
)

select 
    distinct
    *
from ptp_mart