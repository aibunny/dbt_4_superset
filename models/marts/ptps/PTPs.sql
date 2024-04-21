{{
    config(
        alias = 'PTPs'
    )
}}

with ptp_mart as (

    select 
        *,
        row_number() over (partition by ptp_id order by updated_at desc) as rn
    
    from 

    (
        select
            *
        from
            {{ref('int_ptps')}}
        
        union all

        select   
            *
        from
            {{ref('int_new_ptps')}}
    )
)

select 
    distinct
    *
from ptp_mart

where rn = 1