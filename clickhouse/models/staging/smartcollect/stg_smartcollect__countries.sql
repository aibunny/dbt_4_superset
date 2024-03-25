with countries as (
    select 
        id as country_id,
        upper(title) as country_name,
        slug as country_slug,
        calling_code as country_calling_code,
        currency_id,
        created_by,
        created_at::timestamp as created_at,
        case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at


    from
        {{source('smartcollect','countries')}}
    where 
        deleted_at is null and active = 1
)

select * from countries