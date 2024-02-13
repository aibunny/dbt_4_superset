with countries as (
    select 
        *
    from
        {{source('smartcollect','countries')}}
)

select * from countries