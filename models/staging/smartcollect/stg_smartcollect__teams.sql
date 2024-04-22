--- teams

with teams as (
    select
        id as team_id,
        title as team_name,
        {{ coalesce_to_uuid('organization_id') }},
        {{ coalesce_to_uuid('branch_id') }},
        team_type as team_type,
        u.user_name as team_leader,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

    from
        {{source(var('source_db'), 'teams')}}

    left join 
        {{  ref('stg_smartcollect__users')}} u
        on team_leader = u.user_id

    where 
        deleted_at is null and active = {{ get_active_value(target.type) }}
)

select * from teams 