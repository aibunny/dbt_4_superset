with call_types as (
    select 
        *
    from
        {{source('smartcollect','call_types')}}
)

select * from call_types