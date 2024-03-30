--charges

with charges as (
	select
		id as charge_id,
		case_file_id,
		charge_type,
		description,
		coalesce(amount_charged, 0) as amount_charged,
		date_charged::timestamp as date_charged,
		coalesce(percentage_charged,0) as percentage_charged,
		coalesce(balance_before_charge,0) as balance_before_charge,
		coalesce(balance_after_charge,0) as balance_after_charge,
		comments,
		created_at,
		{{ coalesce_to_timestamp('updated_at')}}

	from
		{{source('smartcollect', 'charges')}}

	where
    deleted_at is null
)

select * from charges