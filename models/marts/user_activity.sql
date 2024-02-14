with activity as(
    select
        ap.id as cfid,
        u.user_id,
        u.name as user,
        cs.contact_status,
        ct.contact_type,
        ctypes.call_type,
        case when n.update_type = 'NORMAL' then "Regular Update"
        when n.update_type = 'ON_SMS_SENT' then "Sent SMS"
        when n.update_type = 'ON_PROGRESS_UPDATE' then "Progress Update"
        when n.update_type = 'ON_EMAIL_SENT' then "Sent Email"
        else n.update_type
        end as update_type

    
    from
        {{ ref('int_notes')}} n
    inner join {{ ref('active_portfolio')}} ap on ap.id = n.cfid 
    left join {{ ref('int_users')}} u on n.created_by = u.user_id
    left join {{ ref('int_contact_statuses')}} cs on  cs.contact_status_id = n.contact_status_id
    left join {{ ref('int_contact_types')}} ct on ct.contact_type_id = n.contact_type_id
    left join {{ ref('int_call_types')}} ctypes on ctypes.call_type_id = n.call_type_id

)

select * from activity