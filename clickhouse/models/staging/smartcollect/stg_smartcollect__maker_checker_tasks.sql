select
    id as maker_checker_task_id,
    title as maker_checker_task,
    description as maker_checker_task_description,
    organization_id,
    status as maker_checker_task_status,
    priority as maker_checker_task_priority,
    completed as maker_checker_task_completed,
    claimed as maker_checker_task_claimed,
    claimed_by as maker_checker_task_claimed_by,
    assignees as maker_checker_task_assignees,
    extra_attributes,
    ref_table,
    task_id,
    task_type as maker_checker_task_type,
    job_id,
    process_instance_key,
    due_date::timestamp as due_date,
    follow_up_date::timestamp as follow_up_date,
    deadline as maker_checker_task_deadline,
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    status_date::timestamp as status_date

from {{ source('smartcollect', 'maker_checker_tasks') }}

where
    deleted_at is null