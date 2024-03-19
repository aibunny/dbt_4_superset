with sms as (
    select 
        *
    from {{ source('smartcollect','sms')}}
)

select * from sms