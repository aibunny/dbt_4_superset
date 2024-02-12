with payments as (
    select 
        id as payment_id,
        case_file_id as cfid,
        amount,
        payment_date,
        payment_method,
        payment_type,
        external_id,
        is_confirmed,
        confirmed_by,
        confirmed_date,
        is_reversed,
        reversed_by,
        reversed_date,
        product_id,
        sub_product_id,
        owner_type,
        owner_id,
        created_by,
        created_at,
        deleted_at,
        effort
    from 
        {{ref('stg_smartcollect__payments')}}
)

select * from payments where deleted_at is null