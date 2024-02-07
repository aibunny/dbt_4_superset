--- debt_types

SELECT 
    id ,
	title,
	description,
	active,
	created_by,
	updated_by,
	deleted_by,
	created_at,
	updated_at,
	deleted_at
	
FROM
    {{source('smartcollect', 'debt_types')}}