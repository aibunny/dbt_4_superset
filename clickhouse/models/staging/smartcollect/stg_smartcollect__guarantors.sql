select
    id as guarantor_id,
    names as guarantor,
    case_file_id,
    customer_no,
    coalesce(guaranteed_amount,0),
    created_by,
    updated_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at
from 
    {{source('smartcollect','guarantors')}}
where
    deleted_at is null