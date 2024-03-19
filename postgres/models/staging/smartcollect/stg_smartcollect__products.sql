--- products

with products as (
select
    *
from
    {{ source('smartcollect', 'products')}}
)

select * from products