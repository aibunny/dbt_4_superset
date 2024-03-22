select
    id as comment_id,
    comment,
    status,
    maker_checker_task_id,
    created_by as created_by,
    created_at::timestamp as created_at
from
    {{ source('smartcollect', 'maker_checker_comments') }}
