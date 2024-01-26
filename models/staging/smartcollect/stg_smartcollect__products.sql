--- products

SELECT 
    *
FROM
    {{ source('smartcollect', 'products')}}