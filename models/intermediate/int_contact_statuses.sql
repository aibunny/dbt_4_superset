with refined_contact_statuses as (
    select
        id as contact_status_id,
        title,
        description,
        contact_type_id,
        dialing_priority,
        next_action_days,
        created_by
    from 
        {{ ref('stg_smartcollect__contact_statuses')}}
    where 
        deleted_at is null  and active is TRUE
)

select * from refined_contact_statuses 