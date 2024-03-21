with dim_users as (
    select 
        u.user_id as user_id,
        u.name as name,
        u.user_title as user_title,
        t.team as team,
        o.organization as organization,
        b.branch as branch
    from
        {{ref('int_users')}} u
    left join {{ ref('int_teams') }} t on u.team_id = t.team_id
    left join {{ref('int_organizations')}} o on u.organization_id = o.organization_id
    left join {{ ref('int_branches')}} b on u.branch_id = b.branch_id
)

select * from dim_users