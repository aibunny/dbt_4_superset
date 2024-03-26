select
    id as workflow_task_id,
    upper(title) as workflow_task_name,
    description as workflow_task_description,
    {{ coalesce_to_uuid('organization_id') }},
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
    {{ coalesce_to_timestamp('updated_at')}},

    {{ coalesce_to_timestamp('status_date')}}
from
    {{ source('smartcollect', 'workflow_tasks') }}
where 
    deleted_at is null