select
    id as casefile_movement_id,
    move_to_id, -- as move_to_id,
    move_from_id,
    cfid as case_file_id,
    movement_type as casefile_movement_type,
    movement_completed as is_case_file_movement_completed,
    extra_attributes,
    created_by,
    approved_by,
    deleted_by,
    created_at::timestamp as created_at,
    approved_at::timestamp as created_at,
    deleted_at::timestamp as deleted_at
from 
    {{ source('smartcollect', 'case_file_movements')}}