--- teams

with teams as (
select
    *
from
    {{source('smartcollect', 'teams')}}
)

select * from teams 