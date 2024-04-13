with targets_mart as (
    select 
        *,
        row_number() over (partition by target_id order by updated_at desc) as rn
    
    from 
    ( 
        select
            *
        from
            {{ ref('int_targets')}}

        union all

        select
            *
        from
            {{ ref('int_new_targets')}}
    )
)

select 
    *
from 
    targets_mart
where
    rn = 1
    