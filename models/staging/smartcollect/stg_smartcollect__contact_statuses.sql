--- contact_statuses

SELECT 
    *
FROM
    {{source('sc_db', 'contact_statuses')}}