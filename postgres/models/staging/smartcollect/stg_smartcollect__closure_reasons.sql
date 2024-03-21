with _closure_reason as (
    select
        *
    from
        {{source('smartcollect','closure_reasons')}}
)

select * from _closure_reasons