--- organizations

with organizations as (
    select
        *
    from
        {{source('smartcollect', 'organizations')}}
)

select * from organizations