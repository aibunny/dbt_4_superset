-- payments

with payments as (
    select
        id as payment_id,
        coalesce(amount, 0) AS amount,
        {{ coalesce_to_date('payment_date')}},
        payment_method,
        payment_type,
        reference_no,
        effort,
        "comments",
        coalesce(is_confirmed, false) AS is_confirmed,
        confirmed_by,
        {{ coalesce_to_timestamp('confirmed_date')}},
        coalesce(is_reversed, false) AS is_reversed,
        reversed_by,
        {{ coalesce_to_timestamp('reversed_date')}},
        case_file_id,
        product_id,
        sub_product_id,
        owner_type as owner_type,
        owner_id,
        coalesce(balance_before, 0) AS balance_before,
        coalesce(balance_after, 0) AS balance_after,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}
    from 
        {{ source(var('source_db'), 'payments') }}
    where
        deleted_at is null 
)

select * from payments