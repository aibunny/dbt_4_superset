--- case_files

SELECT
    *
FROM
    {{ source('smartcollect', 'case_files') }} 