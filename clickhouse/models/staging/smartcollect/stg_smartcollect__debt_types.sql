--- debt_types

with debt_types as (
	select
		id as debt_type_id,
		upper(title) as debt_type,
		created_by,
        updated_by,
        created_at,
        {{ coalesce_to_timestamp('updated_at')}}

		
	from
		{{source('smartcollect', 'debt_types')}}
	where
		deleted_at is null and active = 1
)

select * from debt_types