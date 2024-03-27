{{
    config(
        alias = 'Promises To Pay'
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

select * from ptp_mart