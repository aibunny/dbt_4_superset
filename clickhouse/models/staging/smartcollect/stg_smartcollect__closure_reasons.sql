with closure_reasons as (
    select
        id as closure_reason_id,
        title as closure_reason,
        description as closure_reason_description,
        tag as closure_reason_tag,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

    from
        {{source('smartcollect', 'closure_reasons')}}
    where
        deleted_at is null and active = {{ get_active_value(target.type) }}
    )

select * from closure_reasons
