--- branches

with branches as(
    SELECT 
        *
    FROM
        {{source('smartcollect', 'branches')}}
)

select *
from branches