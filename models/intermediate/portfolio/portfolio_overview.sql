--Portfolio overview

WITH portfolio_overview AS (
    
    SELECT
        c.ref_id AS cfid,
        d.names AS customers,
        pd.title as product,
        org.names as organization,
        org.id as organization_id,
        CONCAT(u.first_name,' ',u.last_name) as user,
        u.id as user_id,
        t.title as team,
        t.id AS team_id,
        dt.title as debt_type,
        br.title as branch,
        br.id as branch_id,
        cs.title contact_status,
        ct.title as contact_type,
        bkt.title as bucket,
        del.title as delinquency,
        disp.title as dispute, 
        c.loan_id as loan_id,
        c.account_state as account_state, 
        c.principal_amount as principal_amount, 
        c.loan_amount as loan_amount,
        c.arrears as arrears, 
        c.balance as balance, 
        c.total_payments as total_payments, 
        c.account_no as account_no, 
        c.customer_no as customer_no,
        c.dpd as dpd, 
        c.loan_taken_date as taken_date, 
        c.loan_due_date as due_date, 
        c.allocated as allocated,
        c.traction as traction, 
        c.score as score,
        c.last_action_date as last_action_date, 
        c.next_action_date as next_action_date, 
        c.created_at as created_date
    
    FROM
        {{ source('sc_data', 'case_files') }} c
        INNER JOIN  {{ source('sc_data', 'debtors') }} d ON d.id = c.debtor_id
        INNER JOIN  {{ source('sc_data', 'products') }} pd ON pd.id = c.product_id
        LEFT JOIN   {{ source('sc_data', 'organizations') }} org ON org.id = c.organization_id
        LEFT JOIN {{ source ('sc_data', 'users')}} u ON u.id=c.user_id
        LEFT JOIN {{ source ('sc_data', 'teams')}} t ON t.id=c.team_id
        LEFT JOIN {{ source ('sc_data', 'debt_types')}} dt ON dt.id=c.debt_type_id
        LEFT JOIN {{ source ('sc_data', 'branches')}} br ON br.id=c.branch_id
        LEFT JOIN {{ source ('sc_data', 'contact_statuses')}} cs on cs.id=c.contact_status_id
        LEFT JOIN {{ source ('sc_data', 'contact_types')}} ct on ct.id=c.contact_type_id
        LEFT JOIN {{ source ('sc_data', 'buckets')}} bkt on bkt.id=c.bucket_id
        LEFT JOIN {{ source ('sc_data', 'deliquency_reasons')}} del ON del.id=c.delinquency_reason_id
        LEFT JOIN {{ source ('sc_data', 'dispute_reasons')}} disp ON disp.id=c.dispute_reason_id
   
    WHERE c.deleted_at IS NULL AND c.closed IS FALSE
)

SELECT 
    *
FROM
    portfolio_overview;
