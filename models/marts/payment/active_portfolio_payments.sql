with portfolio_payments as (
    select
        ap.*,
        p.payment_id,
        p.payment_amount,
        p.payment_date,
        p.payment_method,
        p.payment_type,
        p.confirmed_by,
        p.confirmed_date,
        p.owner_type,
        p.owner_id
    from
        {{ref('active_portfolio')}} ap
    inner join {{ref('int_payments')}} p on ap.id = p.cfid
)

select * from portfolio_payments