select
    c.case_file_id as case_file_id,
    sum(c.call_talk_time_in_seconds) as total_call_talk_time,
    count(c.call_campaign_id) as total_campaigns,
    avg(cast(cr.call_rating as integer)) as average_call_rating,
    (current_date - max(date(c.created_at))) as days_since_last_call
from
    {{ ref('stg_smartcollect__calls')}} c
left join 
        {{ref('stg_smartcollect__call_callibrations')}} cr
        on c.call_id = cr.call_id

group by case_file_id