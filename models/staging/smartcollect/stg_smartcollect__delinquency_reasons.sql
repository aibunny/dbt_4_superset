--- delinquency_reasons

SELECT 
    *
FROM
    {{source('smartcollect', 'delinquency_reasons')}}