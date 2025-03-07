select
    id as bpmn_workflow_id,
    title as bpmn_workflow_name,
    description as bpmn_workflow_description,
    module as bpmn_workflow_module,
    trigger as bpmn_workflow_trigger,
    is_global as is_bpmn_workflow_global,
    {{ coalesce_to_uuid('organization_id') }},
    process_id as bpmn_workflow_process_id,
    workflow_engine as bpmn_workflow_engine,
    extra_attributes as bpmn_workflow_attributes,
    file_path as bpmn_workflow_file_path,
    active as is_bpmn_workflow_active,
    created_by,
    updated_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

    
from {{ source(var('source_db'), 'bpmn_workflow_processes')}}

where
    deleted_at is null 


