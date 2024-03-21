select
    id as payment_id,
    coalesce(amount_due, 0) as amount_due,
    start_date::timestamp as start_date,
    type as payment_plan_type,
    active as payment_plan__is_active,
    case_file_id,
    product_id,
    sub_product_id,
    user_id,
    created_by,
    updated_by,
    deleted_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at
from
    {{ source('smartcollect', 'payment_plans') }}