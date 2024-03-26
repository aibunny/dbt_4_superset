--- dispute_reasons

with dispute_reasons as (
    select
        id as dispute_reason_id,
        upper(title) as dispute_reason,
        description,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

    from
        {{source('smartcollect', 'dispute_reasons')}}
    where
		deleted_at is null and active = 1
    
)

select * from dispute_reasons 