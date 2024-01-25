--- debtors

SELECT 
    *
FROM
    {{source('sc_db', 'debtors')}}
