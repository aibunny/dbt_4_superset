{{
    config(
        materialized = 'view'
    )
}}

with refined_notes as (
    select
        n.note_id as activity_id,
        n.case_file_id as case_file_id,
        n.call_type_id as call_type_id,
        n.contact_status_id as contact_status_id,
        n.update_type as activity,
        ct.call_type as call_type,
        cs.contact_status_name as contact_status,
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
        {{ref('stg_smartcollect__contact_statuses')}} cs
        on n.contact_status_id = cs.contact_status_id
    
    left join
        {{ref('int_portfolio')}} p
        on n.case_file_id = p.case_file_id
    
    where
        n.created_at >= {{runtime(run_started_at,target.type)}}
)

select 
    distinct
    * 
from refined_notes