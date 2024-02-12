--- debt_types

with debt_types as (
	select
		id ,
		title,
		description,
		active,
		created_by,
		created_at,
		updated_at,
		deleted_at
		
	from
		{{source('smartcollect', 'debt_types')}}
)

select * from debt_types