{{ config(materialized='view') }}
SELECT 
    *
FROM
    {{ ref('int_portfolio') }}