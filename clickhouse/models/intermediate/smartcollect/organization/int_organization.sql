with organization as (
    select 
        o.organization_id as organization_id,
        o.agency_id as agency_id,
        o.organization_is_primary as organization_is_primary, 
        o.organization_type_id as organization_type_id,
        o.country_id as country_id,
        o.organization_name as organization_name,
        o.organization_multi_currency_enabled  as organization_multi_currency_enabled,
        o.organization_countries_enabled as organization_countries_enabled,
        o.organization_branches_enabled as organization_branches_enabled,
        o.organization_teams_enabled as organization_teams_enabled,
        case 
            when o.organization_teams_enabled = 1 then
            t.team_name else 'Unknown' end as organization_team_name,
        case 
            when o.organization_branches_enabled = 1 then 
            b.branch_name else 'Unknown' end as organization_branch_name,
        case    
            when o.organization_countries_enabled = 1 and 
            o.organization_is_primary = 0 then 
            coalesce(c.country_name,'Unknown') else coalesce(c.country_name,'Unknown')
            end as organization_country_name
        
    from 
        {{ref('stg_smartcollect__organizations')}} o
    left join
        {{ref('stg_smartcollect__teams')}} t on o.organization_id = t.organization_id
    left join 
        {{ref('stg_smartcollect__branches')}} b on o.organization_id = b.organization_id
    left join
        {{ref('stg_smartcollect__countries')}} c on o.country_id = c.country_id 
    left join
        {{ref('stg_smartcollect__users')}} u on o.organization_id = u.organization_id
    

)

select * from organization