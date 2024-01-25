--- buckets

SELECT 
    *
FROM
    {{source('sc_db', 'buckets')}}