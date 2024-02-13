with organization as (
    select 
        id as organization_id,
        organization_type_id,
        names as organization,
        agency_id as agency_id,
        active,
        country_id as country_id,
        currency_id,
        multi_currency_enabled,
        countries_enabled,
        teams_enabled
    
    from
        {{ref('stg_smartcollect__organizations')}}
    where 
        deleted_at is null and active is TRUE
)

select * from organization 