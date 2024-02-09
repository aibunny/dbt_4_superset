--- users

with users as (

    select
        *, 
        CONCAT(u.first_name, ' ', u.last_name) as full_name
    from
        {{source('smartcollect', 'users')}} u
)

select * from users