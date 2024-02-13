--- case_files

with case_files as (
    select
        id,
        ref_id,
        debtor_id,
        external_id,
        loan_id,
        context,
        account_state,
        COALESCE(principal_amount, 0.00) AS principal_amount,
        COALESCE(loan_amount, 0.00) AS loan_amount,
        COALESCE(arrears, 0.00) AS arrears,
        COALESCE(balance, 0.00) AS balance,
        COALESCE(amount_repaid, 0.00) AS amount_repaid,
        COALESCE(total_payments, 0.00) AS total_payments,
        COALESCE(installment_amount, 0.00) AS installment_amount,
        COALESCE(installment_balance, 0.00) AS installment_balance,
        COALESCE(next_installment_amount, 0.00) AS next_installment_amount,
        next_installment_date,
        COALESCE(has_manual_update, false) AS has_manual_update,
        account_no,
        service_account_no,
        contract_no,
        customer_no,
        COALESCE(interest_amount, 0.00) AS interest_amount,
        COALESCE(interest_rate, 0.00) AS interest_rate,
        COALESCE(emi, 0.00) AS emi,
        COALESCE(waived, 0.00) AS waived,
        COALESCE(waived_balance, 0.00) AS waived_balance,
        COALESCE(discount, 0.00) AS discount,
        COALESCE(discount_balance, 0.00) AS discount_balance,
        COALESCE(overdraw_charges, 0.00) AS overdraw_charges,
        COALESCE(penalty_amount, 0.00) AS penalty_amount,
        COALESCE(ledger_fee, 0.00) AS ledger_fee,
        COALESCE(agency_commission, 0.00) AS agency_commission,
        case_branch,
        batch_no,
        dpd,
        loan_term,
        term_fees,
        approval_date,
        disbursment_date,
        loan_taken_date,
        loan_due_date,
        last_paid_date,
        COALESCE(last_paid_amount, 0.00) AS last_paid_amount,
        COALESCE(allocated, false) AS allocated,
        allocation_type,
        organization_id,
        user_id,
        team_id,
        COALESCE(is_new_allocation, false) AS is_new_allocation,
        COALESCE(closed, false) AS closed,
        COALESCE(is_visible, true) AS is_visible,
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
        next_action_date,
        recommendation_id,
        created_by,
        updated_by,
        closed_by,
        deleted_by,
        closed_at,
        reactivated_at,
        last_synced_at,
        extra_attributes,
        created_at,
        updated_at,
        deleted_at,
        COALESCE(traction, 0.00) AS traction,
        traction_date,
        loan_count,
        COALESCE(score, 0.00) AS score,
        workflow_task_id,
        workflow_task_type

    from
        {{ source('smartcollect', 'case_files') }} 
)

select * from case_files