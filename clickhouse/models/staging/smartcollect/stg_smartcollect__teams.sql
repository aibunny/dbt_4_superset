--- teams

with teams as (
    select
        id as team_id,
        title as team_name,
        {{ coalesce_to_uuid('organization_id') }},
        {{ coalesce_to_uuid('branch_id') }},
        team_type as team_type,
        team_leader as team_leader,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

    from
        {{source('smartcollect', 'teams')}}
    where 
        deleted_at is null and active = {{ get_active_value(target.type) }}
)

select * from teams 