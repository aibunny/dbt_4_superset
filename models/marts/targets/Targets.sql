with targets_mart as (
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

select 
    distinct
    *
from targets_mart