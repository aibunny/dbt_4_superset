with users as (
    select 
        id as user_id,
        ref_id,
        identity_id,
        full_name as name,
        title,
        user_type,
        organization_id,
        dialing_extension,
        branch_id,
        team_id,
        created_at
    from
        {{ref('stg_smartcollect__users')}}
    where
        active is TRUE and deleted_at is null
)

select * from users 