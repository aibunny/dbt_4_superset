--- users

with users as (
    select
        id as user_id,
        concat(first_name, ' ', last_name) as user_name,
        title as user_title,
        user_type as user_type,
        {{ coalesce_to_uuid('organization_id') }},
        {{ coalesce_to_uuid('branch_id')}},
        {{ coalesce_to_uuid('team_id')}},
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

        
    from
        {{source('smartcollect', 'users')}} 

    where
        deleted_at is null and active = 1
)

select * from users