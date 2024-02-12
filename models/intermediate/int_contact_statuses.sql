with refined_contact_statuses as (
    select
        id as contact_status_id,
        title,
        description,
        contact_type_id,
        active,
        dialing_priority,
        next_action_days,
        created_by,
        deleted_at
    from {{ ref('stg_smartcollect__contact_statuses')}}
)

select * from refined_contact_statuses where deleted_at is null 