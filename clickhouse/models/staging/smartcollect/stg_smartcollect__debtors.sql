--debt_types

with debt_types as (
    select
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
        created_at,
        updated_at,
        COALESCE(score, 0)  AS score
    from
        {{source('smartcollect', 'debtors')}}
    where
        deleted_at is null
)

select * from debt_types



