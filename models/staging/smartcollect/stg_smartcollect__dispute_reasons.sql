--- dispute_reasons

with dispute_reasons as (
    SELECT 
        *
    FROM
        {{source('smartcollect', 'dispute_reasons')}}
)

select * from dispute_reasons 