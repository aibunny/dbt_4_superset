with payments as (
    select 
        id as payment_id,
        case_file_id as cfid,
        coalesce(amount, 0) as payment_amount,
        payment_date,
        payment_method,
        payment_type,
        confirmed_by,
        confirmed_date,
        product_id,
        sub_product_id,
        effort,
        owner_type,
        owner_id
    from 
        {{ref('stg_smartcollect__payments')}}
    where 
        deleted_at is null and is_confirmed = 1 and is_reversed = 0
)

select * from payments 