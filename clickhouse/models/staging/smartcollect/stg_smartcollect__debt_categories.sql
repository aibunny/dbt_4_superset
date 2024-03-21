select
    id as debt_category_id,
    title as debt_category,
    description as debt_category_description,
    active as debt_category_is_active,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
    deleted_at::timestamp as deleted_at
from 
    {{source( 'smartcollect','debt_categories')}}
