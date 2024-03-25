with closure_reasons as (
    select
        id as closure_reason_id,
        upper(title) as closure_reason,
        description as closure_reason_description,
        tag as closure_reason_tag,
        created_by,
        updated_by,
        created_at::timestamp as created_at,
        case when updated_at is not null then updated_at::timestamp else updated_at end as updated_at

    from
        {{source('smartcollect', 'closure_reasons')}}
    where
        deleted_at is null and active = 1
    )

select * from closure_reasons
