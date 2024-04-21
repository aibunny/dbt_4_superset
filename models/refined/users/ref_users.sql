{{
    config(
        materialized='view'
    )
}}
with users as (
    select 
        u.organization_id,
        count(u.user_id) as users
    
    from 
        {{ ref('stg_smartcollect__users')}} u 
    
    where 
        user_id != '{{var("missing_uuid")}}'

    -- left join {{ ref('stg_smartcollect__branches')}} b
    --     on u.organization_id = b.organization_id

    -- left join {{ ref('stg_smartcollect__teams')}} t
    --     on u.team_id = t.team_id
    group by u.organization_id

)

select * from users