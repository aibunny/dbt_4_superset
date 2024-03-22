select
    id as payment_id,
    coalesce(amount_due, 0) as amount_due,
    start_date::timestamp as start_date,
    type as payment_plan_type,
    case_file_id,
    product_id,
    sub_product_id,
    user_id,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

from
    {{ source('smartcollect', 'payment_plans') }}
where
    deleted_at is null and active = 1
