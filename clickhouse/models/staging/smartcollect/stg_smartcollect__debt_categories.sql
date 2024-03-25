select
    id as debt_category_id,
    upper(title) as debt_category,
    description as debt_category_description,
    created_at::timestamp as created_at,
    case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

from 
    {{source( 'smartcollect','debt_categories')}}

where
    deleted_at is null and active = 1
