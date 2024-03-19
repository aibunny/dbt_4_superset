with users as (
    select 
        id as user_id,
        ref_id,
        identity_id,
        coalesce(full_name,'unknown') as name,
        coalesce(title,'unknown')  as user_title,
        coalesce(user_type, 'unknown') as user_type,
        organization_id,
        dialing_extension,
        branch_id,
        team_id
    from
        {{ref('stg_smartcollect__users')}}
    where
        active is TRUE and deleted_at is null
)

select * from users 