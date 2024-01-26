--- users

WITH users AS (

SELECT 
    *, 
    CONCAT(u.first_name, " " ,u.last_name)
FROM
    {{source('sc_db', 'users')}} u
)

SELECT *

FROM 
    users