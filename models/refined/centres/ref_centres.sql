with refined_centres as (
    select
        c.centre_id as centre_id,
        c.branch_id as branch_id,
        c.centre as centre,
        b.branch_name as branch_name,
        c.created_at as created_at,
        c.updated_at as updated_at
    from
        {{ ref('stg_smartcollect__centres')}} c
    join
        {{ ref('stg_smartcollect__branches')}} b
        on b.branch_id = c.branch_id
)

select * from refined_centres