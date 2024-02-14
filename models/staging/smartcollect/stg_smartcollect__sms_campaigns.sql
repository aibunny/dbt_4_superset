with sms_campaigns as (
    select
        *
    from {{source('smartcollect','sms_campaigns')}}
)

select * from sms_campaigns