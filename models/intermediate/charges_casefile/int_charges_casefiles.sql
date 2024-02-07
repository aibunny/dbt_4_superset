SELECT
    c.*,
    cf.*

FROM
    {{ref('stg_smartcollect__charges')}} c
    LEFT JOIN {{ ref('int_smartcollect_casefiles')}} cf on c.id::text =  cf.cfid::text