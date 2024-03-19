--- debt_types

with debt_types as (
	select
		*
		
	from
		{{source('smartcollect', 'debt_types')}}
)

select * from debt_types