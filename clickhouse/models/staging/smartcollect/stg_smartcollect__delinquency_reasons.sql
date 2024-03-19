--- delinquency_reasons
with delinquency_reasons as (
    select 
        *
    from
        {{source('smartcollect', 'delinquency_reasons')}}
)

select * from delinquency_reasons