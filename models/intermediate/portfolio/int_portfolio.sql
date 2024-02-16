--view materialization
{{ 
  config(
    materialized='view',
  ) 
}}


with active_portfolio as (
    select
        cf.id as id,
        cf.account_state as account_state,
        cf.principal_amount as principal_amount,
        cf.loan_amount as loan_amount,
        cf.arrears as arrears,
        cf.amount_repaid as amount_repaid,
        cf.total_payments as total_payments,
        cf.installment_amount as installment_amount,
        cf.installment_balance as installment_balance,
        cf.next_installment_amount as next_installment_amount,
        cf.next_installment_date as next_installment_date,
        cf.interest_amount as interest_amount,
        cf.interest_rate as interest_rate,
        cf.emi as emi,
        cf.waived as waived,
        cf.waived_balance as waived_balance,
        cf.discount as discount,
        cf.discount_balance as discount_balance,
        cf.overdraw_charges as overdraw_charges,
        cf.penalty_amount as penalty_amount,
        cf.ledger_fee as ledger_fee,
        cf.agency_commission as agency_commission,
        cf.case_branch as case_branch,
        cf.batch_no as batch_no,
        cf.dpd as dpd,
        cf.loan_term as loan_term,
        cf.term_fees as term_fees,
        cf.loan_taken_date as loan_taken_date,
        cf.loan_due_date as loan_due_date,
        cf.allocated as allocated,
        cf.allocation_type as allocation_type,
        cf.is_new_allocation as is_new_allocation,
        cf.traction as traction,
        cf.traction_date as traction_date,
        cf.score as score,
        cf.last_action_date as last_action_date,
        d.debtor_id as debtor_id,
        d.names as debtor,
        d.debtor_type,
        d.gender as debtor_gender,
        d.score as debtor_score,
        o.organization_id as organization_id,
        o.organization as organization,
        o.country as organization_country,
        o.currency as organization_currency,
        u.user_id as user_id,
        u.name as user,
        u.user_title as user_title,
        u.team as user_team,
        p.product_id as product_id,
        p.product as product,
        sp.sub_product_id,
        sp.sub_product as sub_product,
        dt.debt_type_id as debt_type_id,
        dt.debt_type as debt_type,
        cs.collection_stage as collection_stage,
        cur.currency as case_file_currency,
        c.country as case_file_country,
        b.branch as branch,
        b.branch_manager as branch_manager,
        cst.contact_status as contact_status,
        ct.contact_type as contact_type,
        bck.bucket as bucket,
        dr.delinquency_reason as delinquency_reason,
        dsr.dispute_reason as dispute_reason,
        cf.created_at as created_at,
        cf.updated_at as updated_at

    from 
        {{ref('int_casefiles')}} cf
    inner join {{ ref('int_debtors')}} d on cf.debtor_id = d.debtor_id
    left join {{ ref('int_organizations')}} o  on cf.organization_id = o.organization_id
    left join {{ ref('dim_users')}} u on cf.user_id = u.user_id
    left join {{ ref('int_products')}} p on cf.product_id = p.product_id
    left join {{ ref('int_sub_products')}} sp on cf.sub_product_id = sp.sub_product_id
    left join {{ ref('int_debt_types')}} dt on cf.debt_type_id = dt.debt_type_id
    left join {{ ref('int_collection_stages')}} cs on cf.collection_stage_id = cs.collection_stage_id
    left join {{ ref('int_collection_sub_stages')}} css on cf.collection_sub_stage_id = css.collection_sub_stage_id
    left join {{ ref('int_currencies')}} cur on cf.currency_id = cur.currency_id
    left join {{ ref('int_countries')}} c on cf.country_id = c.country_id
    left join {{ ref('int_branches')}} b on cf.branch_id = b.branch_id
    left join {{ ref('int_contact_statuses')}} cst on cf.contact_status_id = cst.contact_status_id
    left join {{ ref('int_contact_types')}} ct on cf.contact_type_id = ct.contact_type_id
    left join {{ ref('int_buckets')}} bck on cf.bucket_id = bck.bucket_id
    left join {{ ref('int_delinquency_reasons')}} dr on cf.delinquency_reason_id = dr.delinquency_reason_id
    left join {{ref('int_dispute_reasons')}} dsr on cf.dispute_reason_id = dsr.dispute_reason_id

    where cf.closed is FALSE 

)

select * from active_portfolio