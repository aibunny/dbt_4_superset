with 

casefiles as (
    select * from {{ ref('int_charges_casefiles')}}
),

casefile_summary as (
    select 
        product,
        organization,
        count(distinct cfid) as "Total Casefiles",
        count(distinct debtor_id) as "Total Debtors",
        sum(principal_amount) as "Total Principal Amount",
        sum(loan_amount) as "Total Loan amount",
        sum(arrears) as "Total arrears",
        sum(balance) as "Total balance",
        sum(total_payments) as "Total payments",
        avg(score) as "Average Score",
        sum(amount_charged) as "Total Amount Charged",
        avg(amount_charged) as "Average Charged",
        avg(percentage_charged) as "Average percentage charged"
    from
        casefiles

    group by product,organization
)

select
    *
from
    casefile_summary