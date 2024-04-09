{{
    config(
        alias = 'Organization'
    )
}}

with organization_mart as (
    select 
        *
    from    
        {{ref('int_organization')}}

    union all

    select
        *
    from
        {{ref('int_new_organization')}}
)

select 
    distinct
    *
from organization_mart