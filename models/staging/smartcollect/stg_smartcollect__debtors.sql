--debtors

with debtors as (
    select
        id as debtor_id,
        COALESCE(customer_no, '') AS customer_no,
        debtor_type as debtor_type,
        COALESCE(pin_number, '') as pin_number,
        COALESCE(gender, '') AS gender,
        dob as date_of_birth,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}},
        COALESCE(score, 0)  AS score
    from
        {{source(var('source_db'), 'debtors')}}
    where
        deleted_at is null
)

select * from debtors



