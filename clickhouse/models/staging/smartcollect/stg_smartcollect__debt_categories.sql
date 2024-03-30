select
    id as debt_category_id,
    title as debt_category,
    description as debt_category_description,
    created_at,
    {{ coalesce_to_timestamp('updated_at')}}

from 
    {{source( 'smartcollect','debt_categories')}}

where
    deleted_at is null and active = {{ get_active_value(target.type) }}
