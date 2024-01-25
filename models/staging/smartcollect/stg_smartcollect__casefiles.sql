--- case_files

SELECT
    *
FROM
    {{ source('sc_data', 'case_files') }} 