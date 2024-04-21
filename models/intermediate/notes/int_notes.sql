with refined_notes as (
    select
        n.note_id as activity_id,
        n.case_file_id as case_file_id,
        n.call_type_id as call_type_id,
        n.contact_status_id as contact_status_id,
        n.update_type as activity,
        ct.call_type as call_type,
        cs.contact_status_name as contact_status,
        cs.contact_type_name as contact_type,
        p.organization as organization,
        p.branch as branch,
        p.team as team,
        p.user as user,
        n.created_at as created_at
    from
        {{ref('stg_smartcollect__notes')}} n 
    
    left join
        {{ref('stg_smartcollect__call_types')}} ct
        on n.call_type_id = ct.call_type_id
    
    left join
        {{ref('ref_contact_status')}} cs
        on n.contact_status_id = cs.contact_status_id
    
    left join
        {{ref('int_portfolio')}} p
        on n.case_file_id = p.case_file_id
)

select 
    distinct
    * 
from refined_notes