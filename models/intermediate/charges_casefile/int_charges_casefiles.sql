SELECT
    cf.*,
    c.charge_type,
    c.amount_charged,
    c.date_charged,
    c.percentage_charged

FROM
    {{ref('stg_smartcollect__charges')}} c
    LEFT JOIN {{ ref('int_portfolio')}} cf ON c.case_file_id = cf.cfid

