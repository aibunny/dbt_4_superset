--- lamda view
.
--- This lambda view includes the most recent data from the
--- int_smartcollect_portfolio table and historical data from the
--- int_smartcollect_portfolio_history table that is not already included 
--- in the int_smartcollect_portfolio table.


WITH lambda_view AS (
  
  SELECT 
    *  
  FROM 
    {{ ref('int_smartcollect_portfolio') }} v
  WHERE 
     v.created_date >= '{{ run_started_at }}'
    
  UNION ALL

  SELECT   
  *  
  FROM 
  {{ ref('int_smartcollect_portfolio_history') }} t
  WHERE t.created_date < '{{ run_started_at }}'
)

SELECT 
  *
FROM 
  lambda_view
