
{{
    config(
        alias = 'Sms Outside Campaigns'
    )
}}

with sms_outside_campaigns as (
    select
        *
    from
        {{ref('int_sms_outside_campaigns')}}
    
    union all

    select
        *
    from
        {{ref('int_new_sms_outside_campaigns')}}
)

select * from sms_outside_campaigns