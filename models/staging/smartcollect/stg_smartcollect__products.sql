--- products

SELECT 
    *
FROM
    {{ source('sc_data', 'products')}}