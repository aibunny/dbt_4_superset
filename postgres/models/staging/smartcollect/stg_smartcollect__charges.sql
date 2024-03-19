--charges

with charges as (
	select
		id,
		external_id,
		case_file_id,
		charge_type,
		description,
		amount_charged,
		date_charged,
		percentage_charged,
		balance_before_charge,
		balance_after_charge,
		"comments",
		created_at,
		updated_at,
		deleted_at
	from
		{{source('smartcollect', 'charges')}}
)

select * from charges