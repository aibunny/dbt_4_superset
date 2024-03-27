{{
    config(
        alias = 'Sms In Campaigns'
    )
}}

with sms_in_campaigns_mart as (
    select
        *
    from
        {{ref('int_sms_in_campaigns')}}
    
    union all
    
    select
        *
    from
        {{ref('int_new_sms_in_campaigns')}}
)

select * from sms_in_campaigns_mart