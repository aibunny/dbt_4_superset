with refined_branches as(
    select
        b.branch_id as branch_id,
        c.centre_id as centre_id,
        b.organization_id as organization_id,
        b.branch_name as branch_name,
        c.centre as centre,
        u.user_name as branch_manager,
        b.created_at as created_at,
        b.updated_at as updated_at
    from
        {{ ref('stg_smartcollect__branches')}} b
    left join
        {{ ref('stg_smartcollect__centres')}} c 
        on b.branch_id = c.branch_id
    join 
        {{ ref('stg_smartcollect__users')}} u 
        on b.branch_manager = u.user_id

)

select * from refined_branches
