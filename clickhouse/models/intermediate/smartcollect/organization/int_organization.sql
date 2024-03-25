with organization as (
    select 
        o.organization_id as organization_id,
        o.organization_is_primary as organization_is_primary, 
        o.organization_type_id as organization_type_id,
        o.country_id as country_id,
        c.country_name as country_name,
        o.organization_name as organization_name,
        ot.organization_type as organization_type,
        o.organization_multi_currency_enabled  as organization_multi_currency_enabled,
        o.organization_countries_enabled as organization_countries_enabled,
        o.organization_branches_enabled as organization_branches_enabled,
        o.organization_teams_enabled as organization_teams_enabled,
        o.created_at as created_at,
        o.updated_at as updated_at

    from 
        {{ref('stg_smartcollect__organizations')}} o
    left join 
        {{ref('stg_smartcollect__countries')}} c on o.country_id = c.country_id 
    left join     
        {{ref('stg_smartcollect__organization_types')}} ot on o.organization_type_id = ot.organization_type_id 
    

)

select * from organization