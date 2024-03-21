select
    id as collateral_id,
    case_file_id,
    name as collateral,
    description as collateral_description,
    type as collateral_type,
    value as collateral_value,
    extra_attributes as collateral_extra_attributes, --json
    created_by,
    updated_by,
    deleted_by,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at
from 
    {{source('smartcollect','collaterals')}}
