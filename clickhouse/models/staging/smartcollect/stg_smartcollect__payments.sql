-- payments

with payments as (
    select
        id as payment_id,
        COALESCE(amount, 0) AS amount,
        {{ coalesce_to_date('payment_date')}},
        payment_method,
        payment_type,
        reference_no,
        effort,
        "comments",
        COALESCE(is_confirmed, false) AS is_confirmed,
        confirmed_by,
        {{ coalesce_to_date('confirmed_date')}},
        COALESCE(is_reversed, false) AS is_reversed,
        reversed_by,
        reversed_date,
        case_file_id,
        product_id,
        sub_product_id,
        upper(owner_type) as owner_type,
        owner_id,
        COALESCE(balance_before, 0) AS balance_before,
        COALESCE(balance_after, 0) AS balance_after,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}
    from 
        {{ source('smartcollect', 'payments') }}
    where
        deleted_at is null 
)

select * from payments