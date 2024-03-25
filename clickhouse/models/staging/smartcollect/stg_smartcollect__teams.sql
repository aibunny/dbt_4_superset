--- teams

with teams as (
    select
        id as team_id,
        upper(title) as team_name,
        {{ coalesce_to_uuid('organization_id') }},
        {{ coalesce_to_uuid('branch_id') }},
        team_type as team_type,
        team_leader as team_leader,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

    from
        {{source('smartcollect', 'teams')}}
    where 
        deleted_at is null and active = 1
)

select * from teams 