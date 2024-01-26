--- debtors

SELECT 
    *
FROM
    {{source('smartcollect', 'debtors')}}
