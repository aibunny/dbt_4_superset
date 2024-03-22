select
    id as ptp_id,
    amount as ptp_amount,
    ptp_date,
    amount_paid,
    date_paid,
    type as ptp_type,
    state as ptp_state,
    case_file_id,
    product_id,
    sub_product_id,
    user_id,
    payment_plan_id,
    escalated_on,
    escalated_to,
    created_by as created_by,
    updated_by as updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
from
    {{ source('smartcollect', 'ptps') }}
where
    deleted_at is null 