{{
    config(
        materialize = 'view'
    )
}}

with refined_ptps as (
    select
        ptp.ptp_id as ptp_id,
        ptp.product_id as product_id,
        ptp.sub_product_id as sub_product_id,
        ptp.user_id as user_id,
        ptp.payment_plan_id as payment_plan_id,
        ptp.ptp_amount as promised_amount,
        ptp.amount_paid as amount_paid,
        ptp.ptp_type as ptp_type,
        ptp.ptp_state as ptp_state,
        p.product_name as product,
        sp.sub_product_name as sub_product,
        u.user_name as user,
        pp.payment_plan_type as payment_plan_type,
        pp.amount_due as payment_plan_amount,
        ptp.escalated_on as escalated_on,
        ptp.escalated_to as escalated_to,
        ptp.date_paid as date_paid,
        ptp.created_at as created_at,
        ptp.updated_at as updated_at
    
    from
        {{ ref('stg_smartcollect__ptps')}} ptp
    
    left join 
        {{ref('stg_smartcollect__products')}} p
        on ptp.product_id = p.product_id

    left join 
        {{ref('stg_smartcollect__sub_products')}} sp
        on ptp.sub_product_id = sp.sub_product_id
    
    left join 
        {{ref('stg_smartcollect__users')}} u
        on ptp.user_id = u.user_id

    left join 
        {{ref('stg_smartcollect__payment_plans')}} pp
        on ptp.payment_plan_id = pp.payment_plan_id
    
    where
        (ptp.updated_at is not null and ptp.updated_at >= {{runtime(run_started_at, target.type)}})
        or ptp.created_at >= {{runtime(run_started_at, target.type)}}
        
)

select * from refined_ptps