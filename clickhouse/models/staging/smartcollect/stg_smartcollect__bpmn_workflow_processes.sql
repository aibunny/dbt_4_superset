select
    id as bpmn_workflow_id
    title as bpmn_workflow_title,
    description as bpmn_workflow_description,
    module as bpmn_workflow_module,
    trigger as bpmn_workflow_trigger,
    is_global as is_bpmn_workflow_global
    organization_id,
    process_id as bpmn_workflow_process_id,
    workflow_engine as bpmn_workflow_engine,
    extra_attributes as bpmn_workflow_attributes,
    file_path as bpmn_workflow_file_path,
    active as is_bpmn_workflow_active,
    created_by,
    updated_by,
    deleted_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at
    
from {{ source('smartcollect', 'bpmn_workflow_processes')}}


