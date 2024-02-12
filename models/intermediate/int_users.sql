with users as (
    select 
        id,
        ref_id,
        identity_id,
        full_name as name,
        title,
        user_type,
        organization_id,
        dialing_extension,
        active,
        enabled,
        branch_id,
        team_id,
        created_by,
        created_at,
        deleted_at
    from
        {{ref('stg_smartcollect__users')}}
)

select * from users where active = TRUE and deleted_at is null