
with refined_payments as (
    select        
        p.payment_id as payment_id,
        p.case_file_id as case_file_id,
        p.product_id as product_id,
        p.sub_product_id as sub_product_id,
        p.owner_id as owner_id,
        case
            when owner_type = 'internal' then
            u.user_id else {{ default_uuid( target.type)}}
            end as user_id,
        p.amount as amount,
        p.payment_date as payment_date,
        p.payment_method as payment_method,
        p.payment_type as payment_type,
        p.effort as effort,
        p.is_confirmed as payment_confirmed,
        p.confirmed_date as confirmed_date,
        p.is_reversed as payment_reversed,
        case 
            when owner_type = 'internal' then
            u.user_name else 'Unknown'
            end as user_name,
        case 
            when owner_type = 'external' then
            1 else 0
            end as owner_is_external,
        p.balance_after as case_file_balance,
        pr.product_name as product,
        spr.sub_product_name as sub_product,
        
        p.created_at as created_at,
        p.updated_at as updated_at
    
    from 
        {{ ref('stg_smartcollect__payments')}} p 
    
    left join 
        {{ ref('stg_smartcollect__products')}} pr
        on p.product_id = pr.product_id
    
    left join 
        {{ ref('stg_smartcollect__sub_products')}} spr
        on p.sub_product_id = spr.sub_product_id
    
    left join 
        {{ ref('stg_smartcollect__users')}} u 
        on p.owner_id = u.user_id
        
)

select * from refined_payments