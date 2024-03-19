with sms_templates as (
    select 
        *
    from 
        {{ source('smartcollect','sms_templates')}}
)

select * from sms_templates