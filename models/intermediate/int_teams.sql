with teams as (
    select
        id as team_id,
        organization_id,
        branch_id,
        agency_id,
        title,
        active,
        team_type,
        team_leader as team_leader_id,
        created_by,
        created_at,
        deleted_at
    from {{ ref('stg_smartcollect__teams') }}
)


select * from teams where deleted_at is null and active is True