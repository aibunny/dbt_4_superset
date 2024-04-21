with ref_contact_status as (
    select
        cs.contact_status_id as contact_status_id,
        ct.contact_type_id as contact_type_id,
        cs.contact_status_name as contact_status_name,
        cs.dialing_priority as dialing_priority,
        cs.next_action_days as next_action_days,
        ct.contact_type_name as contact_type_name,
        cs.created_at as contact_status_created_at,
        cs.updated_at as contact_status_updated_at,
        ct.updated_at as contact_type_updated_at,
        ct.created_at as contact_type_created_at
    from
        {{ref('stg_smartcollect__contact_statuses')}} cs

    left join
        {{ref('stg_smartcollect__contact_types')}} ct
        on cs.contact_status_id = ct.contact_type_id
)

select * from ref_contact_status