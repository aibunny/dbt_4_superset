select 
    id as workflow_id,
    title as workflow_name,
    description as workflow_description,
    module as workflow_module,
    trigger as workflow_trigger,
    action as workflow_action,
    action_model as workflow_action_model,
    action_value as workflow_action_value,
    extra_attributes,
    runs_to as workflow_run_to,
    last_run_at workflow_last_run_at,
    created_by as created_by,
    updated_by as upated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from 
    {{ source(var('source_db'), 'workflows') }}

where
    deleted_at is null and active = {{ get_active_value(target.type) }}