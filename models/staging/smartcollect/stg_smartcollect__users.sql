--- users

WITH users AS (

SELECT 
    *, 
    CONCAT(u.first_name, ' ', u.last_name) as full_name
FROM
    {{source('smartcollect', 'users')}} u
)

SELECT *

FROM 
    users