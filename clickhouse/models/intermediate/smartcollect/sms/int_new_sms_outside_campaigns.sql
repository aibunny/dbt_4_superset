with sms_outside_campaigns as (
    select
        s.sms_id as sms_id,
        s.case_file_id as case_file_id,
        s.organization_id as organization_id,
        s.user_id as user_id,
        s.moderator as moderator,
        s.target as sms_target,
        s.sms_type as sms_type,
        s.scheduled_at as scheduled_at,
        s.approved as sms_approved,
        s.delivery_status as delivery_status,
        s.sms_template_id as sms_template_id,
        s.sent as sms_sent,
        s.sent_at as sms_sent_at,
        s.cost as sms_cost,
        o.organization_name as organization,
        u.user_name as user_name, 
        s.created_at as sms_created_at
    from
        {{ref('stg_smartcollect__sms')}} s

    left join
        {{ref('stg_smartcollect__organizations')}} o
        on s.organization_id = o.organization_id

    left join
        {{ref('stg_smartcollect__users')}} u
        on s.user_id = u.user_id
    
    where
        s.sms_campaign_id = {{default_uuid(target.type)}}
        and s.created_at >= {{runtime(run_started_at,target.type)}}

)

select * from sms_outside_campaigns