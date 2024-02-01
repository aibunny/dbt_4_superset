WITH lambda_query AS (
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

  --ba data

  WHERE t.created_date < '{{ run_started_at }}'
)

SELECT 
  *
FROM 
  lambda_query
