
{{
    config(
        alias = 'Calls Outside Campaigns'
    )
}}

with calls_outside_campaigns_mart as(
    select
        *
    from
        {{ref('int_calls_outside_campaigns')}}
    
    union all
    
    select 
        *
    from
        {{ref('int_new_calls_outside_campaigns')}}
)

select * from calls_outside_campaigns_mart