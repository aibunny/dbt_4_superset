with countries as (
    select 
        id as country_id,
        title as country_name,
        slug as country_slug,
        calling_code as country_calling_code,
        currency_id,
        created_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}


    from
        {{source(var('source_db'),'countries')}}
    where 
        deleted_at is null and active = {{ get_active_value(target.type) }}
)

select * from countries