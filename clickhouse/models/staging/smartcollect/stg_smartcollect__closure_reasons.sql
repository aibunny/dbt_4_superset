with closure_reason as (
select
*
from
{{source('smartcollect', 'closure_reasons')}}
)

select * from closure_reasons
