with organization as (
    select 
        o.id as organization_id,
        o.organization_type_id,
        o.names as organization,
        o.agency_id as agency_id,
        c.country as country,
        cur.currency as currency
    
    from
        {{ref('stg_smartcollect__organizations')}} o
    left join {{ref('int_countries')}} c on o.country_id = c.country_id
    left join {{ref('int_currencies')}} cur on o.currency_id = cur.currency_id
    where 
        deleted_at is null and active = 1
)

select * from organization 