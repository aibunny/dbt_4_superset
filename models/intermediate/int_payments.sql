with payments as (
    select 
        id as payment_id,
        case_file_id as cfid,
        amount,
        payment_date,
        payment_method,
        payment_type,
        is_confirmed,
        confirmed_by,
        confirmed_date,
        is_reversed,
        product_id,
        sub_product_id,
        effort,
        owner_type,
        owner_id,
        created_by,
        created_at,
        deleted_at
    from 
        {{ref('stg_smartcollect__payments')}}
)

select * from payments where deleted_at is null and is_confirmed is TRUE and is_reversed is FALSE