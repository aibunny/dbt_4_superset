with payments as (
    select 
        id as payment_id,
        case_file_id as cfid,
        amount,
        payment_date,
        payment_method,
        payment_type,
        confirmed_by,
        confirmed_date,
        product_id,
        sub_product_id,
        effort,
        owner_type,
        owner_id,
        created_at
    from 
        {{ref('stg_smartcollect__payments')}}
    where 
        deleted_at is null and is_confirmed is TRUE and is_reversed is FALSE
)

select * from payments 