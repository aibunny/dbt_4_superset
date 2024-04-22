{{
    config(
        materialized='view'
    )
}}
with users as (
    select 
        u.organization_id as organization_id,
        u.branch_id as branch_id,
        u.team_id as team_id,
        u.user_name as user_name,
        u.user_type as user_type,
        t.team_name as team_name,
        t.team_type as team_type,
        

        u.created_at as created_at,
        u.updated_at ad updated_at

    
    from 
        {{ ref('stg_smartcollect__users')}} u 
    
    left join 
        {{ ref('stg_smartcollect__teams')}} t

        on u.team_id = t.team_id
    
    left join 
        {{ ref('stg_smartcollect__branches')}} b

        on u.branch_id = b.branch_id
    
    where 
        user_id != '{{var("missing_uuid")}}'

    -- left join {{ ref('stg_smartcollect__branches')}} b
    --     on u.organization_id = b.organization_id

    -- left join {{ ref('stg_smartcollect__teams')}} t
    --     on u.team_id = t.team_id
    group by u.organization_id

)

select * from users