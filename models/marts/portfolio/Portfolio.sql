{{
    config(
        alias = 'Portfolio'
    )
}}

with portfolio_mart  as (
    select 
        *
    from {{ ref('int_portfolio')}} 

    union all

    select
        *
    from {{ ref('int_new_portfolio')}}
)


select * from portfolio_mart