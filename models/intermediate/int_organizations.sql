with organization as (
    select 
        id as organization_id,
        organization_type_id,
        names as name,
        agency_id as agency_id,
        active,
        country_id as country_id,
        currency_id,
        multi_currency_enabled,
        countries_enabled,
        teams_enabled,
        created_by,
        created_at
    
    from
        {{ref('stg_smartcollect__organizations')}}
    where 
        deleted_at is null
)

select * from organization 