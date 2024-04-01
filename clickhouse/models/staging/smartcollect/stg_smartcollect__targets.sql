select
    id as target_id,
    target as target,
    {{coalesce_to_uuid('product_id')}},
    {{coalesce_to_uuid('sub_product_id')}},
    month_year,
    targetable_type,
    {{coalesce_to_uuid('targetable_id')}},
    is_manual_entry,
    {{coalesce_to_date('date')}},
    created_by,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}
from
    {{ source('smartcollect','targets')}}
where deleted_at is null