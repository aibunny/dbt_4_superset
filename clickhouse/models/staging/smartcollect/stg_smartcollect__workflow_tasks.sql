select
    id as workflow_task_id,
    title as workflow_task_name,
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
    {{ coalesce_to_timestamp('due_date')}},
    {{ coalesce_to_timestamp('follow_up_date')}},
    deadline,
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}},

    {{ coalesce_to_timestamp('status_date')}}
from
    {{ source('smartcollect', 'workflow_tasks') }}
where 
    deleted_at is null