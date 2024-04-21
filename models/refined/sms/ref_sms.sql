select
    case_file_id,
    count(sms_id) as total_sms,
    sum(cost) as total_sms_cost,
    (current_date - max(date(created_at))) as days_since_last_sms
from
    {{ref('stg_smartcollect__sms')}}

group by case_file_id