{{
    config(
        alias = 'Activities'
    )
}}

with activity_mart as (
    
    select 
        *
    from
        {{ref('int_notes')}}
    
    union all

    select 
        *
    from
        {{ref('int_new_notes')}}
    
)

select 
    distinct
    *
from activity_mart