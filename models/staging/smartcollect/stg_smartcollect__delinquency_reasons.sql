--- delinquency_reasons
with delinquency_reasons as (
    select 
        id as delinquency_reason_id,
        title as delinquency_reason,
        description as description,
        created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

    from
        {{source(var('source_db'), 'delinquency_reasons')}}
    where
		deleted_at is null and active = {{ get_active_value(target.type) }}
)

select * from delinquency_reasons