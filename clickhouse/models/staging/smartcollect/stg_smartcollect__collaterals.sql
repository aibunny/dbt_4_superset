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
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from 
    {{source('smartcollect','collaterals')}}
where
    deleted_at is null
