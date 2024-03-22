select
    id as debt_category_id,
    title as debt_category,
    description as debt_category_description,
    created_at::timestamp as created_at,
    updated_at::timestamp as updated_at,
from 
    {{source( 'smartcollect','debt_categories')}}

where
    deleted_at is null and active = 1
