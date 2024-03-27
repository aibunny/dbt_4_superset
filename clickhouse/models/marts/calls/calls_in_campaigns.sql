{{
    config(
        alias='Calls In Campaigns'
    )
}}

with calls_in_campaigns_mart as (

    select
        *
    from
        {{ref('int_calls_in_campaigns')}}
    
    union all

    select
        *
    from
        {{ref('int_new_calls_in_campaigns')}}
)

select * from calls_in_campaigns_mart