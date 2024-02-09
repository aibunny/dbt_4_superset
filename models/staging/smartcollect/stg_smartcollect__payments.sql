-- payments

with payments as (
select
    id,
    COALESCE(amount, 0.00) AS amount,
    payment_date,
    payment_method,
    payment_type,
    external_id,
    reference_no,
    "comments",
    COALESCE(is_confirmed, false) AS is_confirmed,
    confirmed_by,
    confirmed_date,
    COALESCE(is_reversed, false) AS is_reversed,
    reversed_by,
    reversed_date,
    case_file_id,
    product_id,
    sub_product_id,
    owner_type,
    owner_id,
    COALESCE(balance_before, 0.0) AS balance_before,
    COALESCE(balance_after, 0.0) AS balance_after,
    created_by,
    updated_by,
    deleted_by,
    created_at,
    updated_at,
    deleted_at,
    effort
from {{ source('smartcollect', 'payments') }}
)

select * from payments