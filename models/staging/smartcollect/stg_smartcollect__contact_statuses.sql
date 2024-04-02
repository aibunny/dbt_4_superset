--- contact_statuses

with contact_statuses as (
    select
        id as contact_status_id,
        title as contact_status_name,
        description as contact_status_description,
        tag as contact_status_tag,
        contact_type_id as contact_type_id,
        dialing_priority as dialing_priority,
        next_action_days as next_action_days,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}


    from
        {{source(var('source_db'), 'contact_statuses')}}
    
    where 
        deleted_at is null and active = {{ get_active_value(target.type) }}   
) 

select * from contact_statuses