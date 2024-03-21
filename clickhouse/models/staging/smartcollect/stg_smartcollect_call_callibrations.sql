select
    id as call_callibration_id,
    call_id,
    cast(ratings as int) as call_rating,
    json_parse(comments) as json_comment_array,
    created_at::timestamp as created_at
from 
    {{ source('smartcollect', 'call_callibrations')}}

    