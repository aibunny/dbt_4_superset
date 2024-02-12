with refined_casefiles as (
    select
        id as cfid,
        debtor_id,
        loan_id,
        account_state,
        case when c.account_state = 'WRITTEN_OFF' then "Write OFF"
        else "DEP" end as segmentation,
        principal_amount,
        loan_amount,
        arrears,
        balance,
        amount_repaid,
        total_payments,
        installment_amount,
        installment_balance,
        next_installment_amount,
        next_installment_date,
        interest_amount,
        interest_rate,
        emi,
        waived,
        waived_balance,
        discount,
        discount_balance,
        overdraw_charges,
        penalty_amount,
        ledger_fee,
        agency_commission,
        case_branch,
        batch_no,
        dpd,
        loan_term,
        term_fees,
        loan_taken_date,
        loan_due_date,
        allocated,
        allocation_type,
        is_new_allocation,
        closed,
        traction,
        traction_date,
        score,
        organization_id, 
        team_id,
        user_id,
        product_id,
        sub_product_id,
        client_id,
        partner_id,
        debt_type_id,
        collection_stage_id,
        collection_sub_stage_id,
        currency_id,
        country_id,
        branch_id,
        contact_status_id,
        contact_type_id,
        bucket_id,        
        delinquency_reason_id,
        dispute_reason_id,
        closure_reason_id,
        last_action_id,
        next_action_id,
        last_action_date,
        created_at,
        closed_at,
        deleted_at    
    from
        {{ref("stg_smartcollect__casefiles")}}
)

select * from case_files where deleted_at is null and closed_at is null