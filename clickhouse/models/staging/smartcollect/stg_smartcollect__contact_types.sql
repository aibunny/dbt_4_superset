--- contact_types
with contact_types as (
    SELECT 
        *
    FROM
        {{source('smartcollect', 'contact_types')}}
)
select * from contact_types