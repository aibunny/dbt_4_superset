--- buckets

with buckets as(
    select
        *
    from
        {{source('smartcollect', 'buckets')}}
)

select * from buckets