with closure_reason as (
    select
        id as closure_reason_id,
        title as closure_reason,
        description as closure_reason_description,
        tag as closure_reason_tag,
        active as closure_reason_is_active,
        created_by,
        updated_by,
        deleted_by,
        created_at::timestamp as created_at,
        updated_at::timestamp as updated_at,
        deleted_at::timestamp as deleted_at

    from
    {{source('smartcollect', 'closure_reasons')}}
    )

select * from closure_reasons
