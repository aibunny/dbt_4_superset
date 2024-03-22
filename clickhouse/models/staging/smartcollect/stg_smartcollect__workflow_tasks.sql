select
    id as workflow_task_id,
    title as workflow_task_name,
    description as workflow_task_description,
    organization_id,
    status as workflow_task_status,
    priority,
    completed,
    claimed,
    claimed_by,
    assignees,
    task_id,
    task_type,
    due_date::timestamp as  due_date,
    follow_up_date::timestamp as follow_up_date,
    deadline::timestamp as deadline,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at,

    status_date::timestamp as status_date
from
    {{ source('smartcollect', 'workflow_tasks') }}
where 
    deleted_at is null