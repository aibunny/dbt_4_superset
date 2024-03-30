select
    id as approval_id,
    table_ref_id,
    approval_id as approval_level_id,
    organization_id,
    notes as approval_rejection_notes,
    rejected as is_approval_rejected,
    reject_notes as is_approval_rejected_with_notes,
    priority as approval_priority,
    assignees as approval_assignees,
    claimed as is_approval_claimed,
    {{coalesce_to_uuid('claimed_by')}},
    created_at
    
from {{ source('smartcollect', 'approvals')}}
where
    deleted_at is null 


--TODO: Flatted approval assignees