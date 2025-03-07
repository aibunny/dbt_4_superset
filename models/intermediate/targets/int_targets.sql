with refined_targets as (
    select
        t.target_id as target_id,
        t.product_id as product_id,
        t.sub_product_id as sub_product_id,
        u.user_id as user_id,
        tm.team_id as team_id,
        b.branch_id as branch_id,
        o.organization_id as organization_id,
        t.target as target_amount,
        t.month_year as month_year,
        t.date as date,
        t.targetable_type as target_group,
        p.product_name as product,
        sp.sub_product_name as sub_product,
        u.user_name as user,
        tm.team_name as team,
        b.branch_name as branch,
        o.organization_name as organization,
        t.created_at as created_at,
        t.updated_at as updated_at
    
    from 
        {{ ref('stg_smartcollect__targets')}} t
    
    left join
        {{ ref('stg_smartcollect__sub_products')}} sp
        on t.sub_product_id = sp.sub_product_id

    left join
        {{ ref('stg_smartcollect__products')}} p
        on t.product_id = p.product_id
    
    left join
        {{ ref('stg_smartcollect__organizations')}} o 
        on t.targetable_id = o.organization_id

    left join
        {{ ref('stg_smartcollect__users')}} u
        on t.targetable_id = u.user_id
    
    left join
        {{ ref('stg_smartcollect__teams')}} tm
        on t.targetable_id = tm.team_id
    
    left join
        {{ ref('stg_smartcollect__branches')}} b
        on t.targetable_id = b.branch_id

)

select 
    distinct
    * 
from refined_targets