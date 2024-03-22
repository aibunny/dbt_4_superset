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
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

from 
    {{source('smartcollect','collaterals')}}
where
    deleted_at is null
