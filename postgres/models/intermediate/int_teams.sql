with teams as (
    select
        id as team_id,
        organization_id,
        branch_id,
        agency_id,
        title as team,
        team_type,
        team_leader as team_leader_id
    from 
        {{ ref('stg_smartcollect__teams') }}
    where 
        deleted_at is null and active = 1
)


select * from teams 