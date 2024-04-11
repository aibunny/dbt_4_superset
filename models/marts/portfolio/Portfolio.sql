{{
    config(
        alias = 'Portfolio'
    )
}}

with portfolio_mart  as (
    
    select 
        *,
        row_number() over (partition by case_file_id order by updated_at desc) as rn
    
    from 
        (select 
            
            *
        from {{ ref('int_portfolio')}} 

        union all

        select
            
            *
        from {{ ref('int_new_portfolio')}} )
)


select 
    *
from portfolio_mart
where rn = 1