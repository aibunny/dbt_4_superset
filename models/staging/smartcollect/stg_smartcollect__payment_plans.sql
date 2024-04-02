select
    id as payment_plan_id,
    coalesce(amount_due, 0) as amount_due,
    {{ coalesce_to_timestamp('start_date') }},
    type as payment_plan_type,
    case_file_id,
    product_id,
    sub_product_id,
    user_id,
    created_by,
    updated_by,
    created_at,
    {{coalesce_to_timestamp('updated_at')}}

from
    {{ source(var('source_db'), 'payment_plans') }}
where
    deleted_at is null and active = {{ get_active_value(target.type) }}
