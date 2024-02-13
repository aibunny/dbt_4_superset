
{{ 
  config(
    materialized='table'
  )
}}

with active_portfolio as (
    select
        cf.id,
        cf.account_state,
        cf.principal_amount,
        cf.loan_amount,
        cf.arrears,
        cf.amount_repaid,
        cf.total_payments,
        cf.installment_amount,
        cf.installment_balance,
        cf.next_installment_amount,
        cf.next_installment_date,
        cf.interest_amount,
        cf.interest_rate,
        cf.emi,
        cf.waived,
        cf.waived_balance,
        cf.discount,
        cf.discount_balance,
        cf.overdraw_charges,
        cf.penalty_amount,
        cf.ledger_fee,
        cf.agency_commission,
        cf.case_branch,
        cf.batch_no,
        cf.dpd,
        cf.loan_term,
        cf.term_fees,
        cf.loan_taken_date,
        cf.loan_due_date,
        cf.allocated,
        cf.allocation_type,
        cf.is_new_allocation,
        cf.traction,
        cf.traction_date,
        cf.score,
        cf.last_action_date,
        d.names as debtor,
        d.debtor_type,
        d.gender as debtor_gender,
        d.score as debtor_score,
        o.organization,
        o.country as organization_country,
        o.currency as organization_currency,
        u.name as user,
        u.user_title as user_title,
        u.team as user_team,
        p.product,
        sp.sub_product,
        dt.debt_type,
        cs.collection_stage,
        cur.currency as case_file_currency,
        c.country as case_file_country,
        b.branch,
        b.branch_manager,
        cst.contact_status,
        ct.contact_type,
        bck.bucket,
        dr.delinquency_reason,
        dsr.dispute_reason,
        cf.created_at,
        cf.updated_at

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