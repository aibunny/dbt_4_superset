
SELECT 
    id,
    COALESCE(salutation, '') AS salutation,
    names,
    COALESCE(identification, '') AS identification,
    COALESCE(customer_no, '') AS customer_no,
    debtor_type,
    COALESCE(pin_number, '') AS pin_number,
    COALESCE(gender, '') AS gender,
    dob,
    COALESCE(external_id, '') AS external_id,
    created_by,
    updated_by,
    deleted_by,
    created_at,
    updated_at,
    deleted_at,
    COALESCE(score, 0.0) AS score
FROM
    {{source('smartcollect', 'debtors')}}




