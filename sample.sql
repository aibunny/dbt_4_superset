SELECT 
c.id AS cfid,
c.loan_id as loan_id,
c.account_state as account_state, 
d.names as debtor, 
d.identification as identification, 
d.customer_no as customer_id,
c.principal_amount as principal_amount,
c.loan_amount as loan_amount,c.arrears as arrears, 
c.balance as balance,c.total_payments as total_payments,
p.amount as payment_amount, 
p.payment_date as payment_date, 
p.payment_method as payment_method,
p.payment_type as payment_type,
p.created_at as created_date,
p.payment_segment as payment_segment,
p.owner_type as owner_type, 
p.owner_id as owner_id,
pd.title as product,
branches.title as branch,
centres.title as centre,
c.dpd as dpd,
c.days_late as days_late,
buckets.title as bucket,
CASE WHEN p.owner_type="user" THEN u.names WHEN p.owner_type="agency" THEN agencies.names ELSE 'No Owner' END as owner,
ct.title as contact_type, 
cs.title as contact_status, 
dr.title as delinquency, 
disp.title as dispute_reason,
c.loan_taken_date as taken_date, 
c.loan_due_date as due_date
FROM payments p 
INNER JOIN case_files  c ON c.id=p.case_file_id
INNER JOIN debtors d ON c.debtor_id=d.id 
LEFT JOIN products pd ON pd.id=c.product_id 
LEFT JOIN branches  ON branches.id=c.branch_id
LEFT JOIN centres ON centres.id=c.centre_id 
LEFT JOIN buckets ON buckets.id=c.bucket_id 
LEFT JOIN contact_statuses cs ON cs.id=p.contact_status_id 
LEFT JOIN contact_types ct ON ct.id=cs.contact_type_id 
LEFT JOIN delinquency_reasons dr ON dr.id=c.delinquency_reason_id 
LEFT JOIN dispute_reasons disp ON disp.id=c.dispute_reason_id 
LEFT JOIN agencies ON p.owner_type = 'agency' AND p.owner_id = agencies.id 
LEFT JOIN users u ON p.owner_type = 'user' AND p.owner_id = u.id
WHERE p.is_confirmed=1 AND p.is_reversed=0 AND c.deleted_at is NULL AND p.deleted_at is NULL
