with refined_closure_reasons as (
    select
        id as closure_reasons_id,
        title as closure_reason,
        description as closure_reason_description
    from 
        {{ref('stg_smartcollect__closure_reasons')}}

    where deleted_at is null and active is TRUE
)

select * from refined_closure_reasons