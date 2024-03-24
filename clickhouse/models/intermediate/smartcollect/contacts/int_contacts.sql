with contacts as (
    select 
        ct.contact_type_id as contact_type_id,
        ct.contact_type_name as contact_type_name,        
        cs.contact_status_id as contact_status_id,
        cs.contact_status_name as contact_status_name,
        cs.dialing_priority as dialing_priority,
        cs.created_at as contact_created_at

    from 
        {{ref('stg_smartcollect__contact_types')}} ct
    left join 
        {{ref("stg_smartcollect__contact_statuses")}} cs on ct.contact_type_id = cs.contact_type_id

)

select * from contacts