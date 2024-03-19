with currencies as (
    select 
        *
    from 
        {{source('smartcollect','currencies')}}
)

select * from currencies