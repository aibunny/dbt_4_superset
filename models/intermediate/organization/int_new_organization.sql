{{
    config(
        materialized='view'
    )
}}

with refined_organization as (
    select 
        o.organization_id as organization_id,
        o.organization_type_id as organization_type_id,
        o.country_id as country_id,
        t.team_id as team_id,
        t.team_leader_id as team_leader_id,
        u.user_id as user_id,        
        b.branch_id as branch_id,
        b.centre_id as centre_id,
        o.organization_is_primary as organization_is_primary,
        o.organization_type as organization_type,
        o.organization_name as organization,
        o.country_name as country,
        b.branch_name as branch,
        b.branch_manager as branch_manager,
        b.centre as centre,   
        u.user_name as user,    
        o.organization_countries_enabled as organization_countries_enabled,
        o.organization_teams_enabled as organization_teams_enabled,
        o.organization_branches_enabled as organization_branches_enabled,
        o.organization_multi_currency_enabled as organization_multi_currency_enabled,
        t.team_name as team,
        t.team_type as team_type,
        t.team_leader as team_leader,  
        o.created_at as created_at,
        o.updated_at as updated_at
        
    from 
        {{ref("ref_organization")}} o
    left join 
        {{ref('ref_branches')}} b on 
        o.organization_id = b.organization_id
    left join 
        {{ref('ref_teams')}} t on 
        o.organization_id = t.organization_id 
    left join 
        {{ref('stg_smartcollect__users')}} u
        on o.organization_id = u.organization_id
    
    where
        (o.updated_at >= {{runtime(run_started_at, target.type)}}
        and o.updated_at is null) or 
        o.created_at >= {{runtime(run_started_at, target.type)}}
)

select 
    * 
from refined_organization