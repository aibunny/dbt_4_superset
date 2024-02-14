with notes as (
    select
        *
    from
        {{source('smartcollect','notes')}}
)