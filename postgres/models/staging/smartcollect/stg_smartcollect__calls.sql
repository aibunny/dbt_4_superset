-- calls

with calls as (
select
    *
from
    {{ source('smartcollect', 'calls')}}
)

select * from calls