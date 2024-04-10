
{{
    config(
        materialized='view'
    )
}}

with refined_case_files as(
    select
        c.case_file_id as case_file_id,
        c.organization_id as organization_id,
        c.user_id as user_id,
        c.loan_id as loan_id, --TODO:
        c.team_id as team_id,
        c.branch_id as branch_id,
        c.product_id as product_id,
        c.sub_product_id as sub_product_id,
        c.bucket_id as bucket_id,
        c.currency_id as currency_id,
        c.debt_type_id as debt_type_id,
        c.collection_stage_id as collection_stage_id,
        c.collection_sub_stage_id as collection_sub_stage_id,
        c.contact_status_id as contact_status_id,
        c.contact_type_id as contact_type_id,
        c.delinquency_reason_id as delinquency_reason_id,
        c.dispute_reason_id as dispute_reason_id,
        c.workflow_task_id as workflow_task_id, 

        c.interest_amount as interest_amount,
        c.interest_rate as interest_rate,
        c.emi as emi,
        c.waived as waived,
        c.waived_balance as waived_balance,
        c.discount as discount,
        c.discount_balance as discount_balance,
        c.overdraw_charges as overdraw_charges,
        c.penalty_amount as penalty_amount,
        c.ledger_fee as ledger_fee,
        c.agency_commission as agency_commission,
        c.principal_amount as principal_amount,
        c.loan_amount as loan_amount,
        c.arrears as arrears,
        c.balance as balance,
        c.amount_repaid as amount_repaid,
        c.total_payments as total_payments,
        c.installment_amount as installment_amount,
        c.installment_balance as installment_balance,
        c.next_installment_amount as next_installment_amount,
        c.last_paid_amount as last_paid_amount,
        c.is_new_allocation as is_new_allocation,
        c.score as score,
        c.traction as traction,
        c.closed as closed,
        c.allocated as allocated,
        c.account_state as account_state,        
        c.has_manual_update as has_manual_update,
        c.case_branch as case_branch,
        c.batch_no as batch_no,
        c.dpd as days_past_due,
        c.loan_term as loan_term,
        c.term_fees as term_fees,       
        c.allocation_type as allocation_type,
        c.is_visible as is_visible,        
        c.created_by as created_by,
        c.closed_by as closed_by,
        c.loan_count as loan_count,
        c.workflow_task_type as workflow_task_type,

        d.debtor_type as debtor_type,
        d.gender as debtor_gender,
        o.organization_name as organization,
        o.organization_is_primary as organization_is_primary,
        o.organization_type as organization_type,
        o.country_name as country,
        u.user_name as user,
        u.user_type as user_type,
        u.branch_name as branch,
        u.team_name as team,
        p.product_name as product,
        p.sub_product_name as sub_product,
        b.bucket_name as bucket,
        b.upper_limit as bucket_upper_limit,
        b.lower_limit as bucket_lower_limit,
        cu.currency_symbol as currency,
        dt.debt_type as debt_type,
        cs.collection_stage_name as collection_stage,
        css.collection_sub_stage_name as collection_sub_stage,
        ct.contact_type_name as contact_type,
        cst.contact_status_name as contact_status,
        dr.delinquency_reason as delinquency_reason,
        ds.dispute_reason as dispute_reason,
        wt.workflow_task_name as workflow_task,
        wt.workflow_task_status as workflow_task_status,
        wt.completed as workflow_task_completed,
        wt.priority as workflow_task_priority,
        -- cl.*,
        c.next_installment_date as next_installment_date,
        c.approval_date as approval_date,
        c.disbursment_date as disbursment_date,
        c.loan_taken_date as loan_taken_date,
        c.loan_due_date as loan_due_date,
        c.last_synced_at as last_synced_at,
        c.traction_date as traction_date,
        c.last_action_date as last_action_date,
        c.next_action_date as next_action_date,
        c.last_paid_date as last_paid_date,
        c.closed_at as closed_at,
        c.reactivated_at as reactivated_at,
        c.created_at as created_at,
        c.updated_at as updated_at

    from 
        {{ ref('stg_smartcollect__case_files') }} c 
    left join
        {{ ref('stg_smartcollect__debtors') }} d on 
        c.debtor_id = d.debtor_id
    left join
        {{ ref('ref_organization') }} o on 
        c.organization_id = o.organization_id 
    left join
        {{ ref('int_users') }} u on
        c.user_id = u.user_id
    left join
        {{ ref('int_products') }} p on 
        c.sub_product_id = p.sub_product_id
        or c.product_id = p.product_id
    -- left join
    --     {{ref('int_clients') }} cl on
    --     c.client_id = cl.client_id
    left join
        {{ref('stg_smartcollect__buckets')}} b on
        c.bucket_id = b.bucket_id
    left join
        {{ref('stg_smartcollect__currencies')}} cu on 
        c.currency_id = cu.currency_id
    left join 
        {{ref('stg_smartcollect__debt_types')}} dt on
        c.debt_type_id = dt.debt_type_id
    left join
        {{ ref('int_collection_stages')}} cs on
        c.collection_stage_id = cs.collection_stage_id
    left join
        {{ ref('stg_smartcollect__collection_sub_stages')}} css on
        c.collection_stage_id = css.collection_sub_stage_id

    left join 
        {{ ref('stg_smartcollect__contact_types')}} ct on
        c.contact_type_id = ct.contact_type_id        
    
    left join 
        {{ ref('stg_smartcollect__contact_statuses')}} cst on
        c.contact_status_id = cst.contact_status_id

    left join
        {{ ref('stg_smartcollect__delinquency_reasons')}} dr on
        c.delinquency_reason_id = dr.delinquency_reason_id
    left join
        {{ ref('stg_smartcollect__dispute_reasons')}} ds on
        c.dispute_reason_id = ds.dispute_reason_id
    left join
        {{ ref('stg_smartcollect__workflow_tasks')}} wt on
        c.workflow_task_id = wt.workflow_task_id
    
    where 
        (c.updated_at >= {{ runtime(run_started_at, target.type) }}
        and c.updated_at is not null )
        or c.created_at >= {{ runtime(run_started_at, target.type) }}
)

select 
    distinct
    * 
from refined_case_files

