with sms_templates as (
    select 
        *
    from 
        {{ source(var('source_db'),'sms_templates')}}
)

select * from sms_templates