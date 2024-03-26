with clients as (
    select
        cl.client_id as client_id,
        cl.client_type_id as client_type_id,
        cl.client_name as client_name,
        cl.general_target as client_general_target,
        cl.general_commission as client_general_commission,
        ct.client_type as client_type,
        cl.created_at as client_created_at,
        co.country_name as client_country,
        b.branch_name as client_branch,
        p.product_name as clients_product,
        u.user_name as client_team_lead
        


    from
        {{ref('stg_smartcollect__clients')}} cl 
        
    left join 
        {{ref('stg_smartcollect__client_types')}} ct
        on cl.client_type_id = ct.client_type_id

    left join
        {{ref('stg_smartcollect__client_products')}} cp
        on cl.client_id = cp.client_id
    left join
        {{ref('stg_smartcollect__countries')}} co
        on cl.country_id = co.country_id
    left join
        {{ref('stg_smartcollect__users')}} u
        on cl.team_leader_id = u.user_id 
    left join
        {{ref('stg_smartcollect__branches')}} b 
        on cl.branch_id = b.branch_id  
    left join
        {{ ref('stg_smartcollect__products')}} p
        on cp.product_id = p.product_id
    
)

select * from clients
