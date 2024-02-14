with active_portfolio_lambda_view as (
  
  select
    *  
  from 
    {{ ref('int_portfolio') }} v
  where 
    (v.updated_at >= '{{ run_started_at }}' and v.updated_at is not null) 
    or v.created_at >= '{{ run_started_at }}'
    
  union all

  select   
  *  
  from 
  {{ ref('int_portfolio_history') }} t
  where 
    t.updated_at < '{{ run_started_at }}' or t.updated_at is null
)

select
  *
from 
  active_portfolio_lambda_view
