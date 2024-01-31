WITH lambda_query AS (
  SELECT 
    *
  FROM 
    {{ ref('int_smartcollect_portfolio') }}
    
  UNION ALL

  SELECT *
  FROM 
  {{ ref('int_smartcollect_portfolio_history') }}
)

SELECT *
FROM lambda_query
