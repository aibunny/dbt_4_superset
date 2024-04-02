--- debt_types

with debt_types as (
	select
		id as debt_type_id,
		title as debt_type,
		created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

		
	from
		{{source(var('source_db'), 'debt_types')}}
	where
		deleted_at is null and active = {{ get_active_value(target.type) }}
)

select * from debt_types