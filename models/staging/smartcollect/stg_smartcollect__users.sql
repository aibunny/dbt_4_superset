--- users

SELECT 
    *
FROM
    {{source('sc_db', 'users')}}