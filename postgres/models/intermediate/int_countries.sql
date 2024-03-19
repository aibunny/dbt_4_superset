with refined_countries as (
    select
        id as country_id,
        title as country,
        currency_id
    from
        {{ref('stg_smartcollect__countries')}}
    where 
        deleted_at is null and active is TRUE
)

select * from refined_countries