with users as (
    select 
        u.user_id as user_id,
        u.organization_id as organization_id,
        u.branch_id as branch_id,
        u.team_id as team_id,
        u.user_name as user_name,
        u.user_type as user_type,        
        b.branch_name as branch_name,
        o.organization_name as organization_name,
        t.team_name as team_name,
        u.created_at as created_at,
        u.created_by as created_by
    
    from 
        {{ ref('stg_smartcollect__users')}} u 
    left join {{ ref('stg_smartcollect__organizations')}} o on u.organization_id = o.organization_id

    left join {{ ref('stg_smartcollect__branches')}} b on u.organization_id = b.organization_id

    left join {{ ref('stg_smartcollect__teams')}} t on u.team_id = t.team_id

)

select * from users