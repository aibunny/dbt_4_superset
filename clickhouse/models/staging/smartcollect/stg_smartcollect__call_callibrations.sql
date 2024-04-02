select
    id as call_callibration_id,
    call_id,
    ratings  as call_rating,
    comments as json_comment_array,
    created_at
from 
    {{ source(var('source_db'), 'call_callibrations')}}

