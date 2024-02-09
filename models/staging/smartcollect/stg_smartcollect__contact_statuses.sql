--- contact_statuses

with contact_statuses as (
select
    *
from
    {{source('smartcollect', 'contact_statuses')}}
) 

select * from contact_statuses