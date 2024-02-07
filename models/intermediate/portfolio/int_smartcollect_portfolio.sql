/*
This model provides a comprehensive overview of the portfolio,
including information about customers, products, organizations, users,
teams, debt types, branches, contact statuses, contact types, buckets,
delinquency reasons, and dispute reasons.
The model is based on the stg_smartcollect__casefiles table and joins
various other tables to extract relevant information. 
```dbt
    columns:
      - name: cfid
        description: Reference ID for the case file
        label: Case File ID
        tests:
            - unique
      - name: customers
        description: Names of the customers
        label: Customer Names

      - name: product
        description: Title of the product
        label: Product Title
        tests:
            - not_null
            - unique
      - name: organization
        description: Name of the organization
        label: Organization Name
        tests:
            - not_null
            - unique
      - name: organization_id
        description: ID of the organization
        label: Organization ID
        tests:
            - not_null
            - unique
      - name: user
        description: Full name of the user
        label: USer Full Name
        tests:
            - not_null

      - name: user_id
        description: ID of the user
        label: User ID
        tests:
            - unique

      - name: team
        description: Title of the team
        label: Team Title
        tests:
            - not_null

      - name: team_id
        description: ID of the team
        label: Team ID
        tests:
          - not_null
          - unique

      - name: debt_type
        description: Title of the debt type
        label: Debt Type Title
        tests:
          - not_null

      - name: branch
        description: Title of the branch
        label: Branch Title
        tests:
          - not_null
          - unique

      - name: branch_id
        description: ID of the branch
        tests:
            - unique
            - not_null

      - name: contact_status
        description: Title of the contact status
        label: Contact Status Title
        tests:
          - not_null

      - name: contact_type
        description: Title of the contact type
        label: Contact Type Title
        tests:
          - not_null

      - name: bucket
        description: Title of the bucket
        label: Bucket Title
        tests:
          - not_null

      - name: delinquency
        description: Title of the delinquency reason
        label: Delinquency Reason Title
        tests:
          - not_null

      - name: dispute
        description: Title of the dispute reason
        label: Dispute Reason Title
        tests:
          - not_null
      
      - name: loan_id
        description: ID of the loan
        label: Loan ID
        tests:
          - not_null
          - unique

      - name: account_state
        description: State of the account
        label: Account State
        tests:
          - not_null

      - name: principal_amount
        description: Principal amount of the loan
        label: Principal Amount
        tests:
          - not_null

      - name: loan_amount
        description: Loan amount
        label: Loan Amount
        tests:
          - not_null

      - name: arrears
        description: Arrears on the loan
        label: Arrears
        tests:
          - not_null

      - name: balance
        description: Balance of the loan
        label: Balance
        tests:
          - not_null

      - name: total_payments
        description: Total payments made on the loan
        label: Total Payments
        tests:
          - not_null

      - name: account_no
        description: Account number
        label: Account Number
        tests:
          - not_null
          - unique

      - name: customer_no
        description: Customer number
        label: Customer Number
        tests:
          - not_null
          - unique

      - name: dpd
        description: Days past due
        label: Days Past Due
        tests:
          - not_null

      - name: taken_date
        description: Date when the loan was taken
        label: Loan Taken Date
        tests:
          - not_null
      
      - name: due_date
        description: Due date of the loan
        label: Loan Due Date
        tests:
          - not_null

      - name: allocated
        description: Allocation status of the loan
        label: Allocation Status
        tests:
          - not_null

      - name: traction
        description: Traction status of the loan
        label: Traction Status
        tests:
          - not_null

      - name: score
        description: Score of the loan
        label: Loan Score
        tests:
          - not_null

      - name: last_action_date
        description: Date of the last action taken on the loan
        label: Last Action Date
        tests:
          - not_null

      - name: next_action_date
        description: Date of the next action to be taken on the loan
        label: Next Action Date
        tests:
          - not_null
          
      - name: created_date
        description: Date when the loan was created
        label: Created Date
        tests:
          - not_null
```
*/


--view materialization
{{ 
  config(
    materialized='view',
  ) 
}}

SELECT
    c.ref_id AS cfid,
    d.names AS customers,
    pd.title as product,
    org.names as organization,
    org.id as organization_id,
    u.full_name as user,
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
    {{ ref('stg_smartcollect__casefiles') }} c
    INNER JOIN  {{ ref('stg_smartcollect__debtors') }} d ON d.id = c.debtor_id
    INNER JOIN  {{ ref('stg_smartcollect__products') }} pd ON pd.id = c.product_id
    LEFT JOIN   {{ ref('stg_smartcollect__organizations') }} org ON org.id = c.organization_id
    LEFT JOIN {{ ref('stg_smartcollect__users')}} u ON u.id=c.user_id
    LEFT JOIN {{ ref('stg_smartcollect__teams')}} t ON t.id=c.team_id
    LEFT JOIN {{ ref('stg_smartcollect__debt_types')}} dt ON dt.id=c.debt_type_id
    LEFT JOIN {{ ref('stg_smartcollect__branches')}} br ON br.id=c.branch_id
    LEFT JOIN {{ ref('stg_smartcollect__contact_statuses')}} cs on cs.id=c.contact_status_id
    LEFT JOIN {{ ref('stg_smartcollect__contact_types')}} ct on ct.id=c.contact_type_id
    LEFT JOIN {{ ref('stg_smartcollect__buckets')}} bkt on bkt.id=c.bucket_id
    LEFT JOIN {{ ref('stg_smartcollect__deliquency_reasons')}} del ON del.id=c.delinquency_reason_id
    LEFT JOIN {{ ref('stg_smartcollect__dispute_reasons')}} disp ON disp.id=c.dispute_reason_id
    WHERE c.deleted_at IS NULL AND c.closed IS FALSE 

