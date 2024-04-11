with teams as (
    select
        t.team_id as team_id,      
        t.organization_id as organization_id,
        t.branch_id as branch_id,
        t.team_leader as team_leader_id,
        t.team_name as team_name,
        t.team_type as team_type,     
        b.branch_name as branch_name,
        u.user_name as team_leader,
        t.created_at,
        t.updated_at

    from
        {{ref('stg_smartcollect__teams')}} t
    left join
        {{ref('stg_smartcollect__users')}} u on t.team_leader = u.user_id
    left join
        {{ref('stg_smartcollect__branches')}} b on t.branch_id = b.branch_id
)

select * from teams