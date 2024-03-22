with sms_in_campaigns as (
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
        s.created_at as sms_created_at,

        sc.sms_campaign_name as sms_campaign_name,
        sc.sms_campaign_target as sms_campaign_target,
        sc.sms_campaign_end_date as sms_campaign_end_date,
        sc.created_by as sms_campaign_created_by,
        sc.created_at as sms_campaign_created_at





    from
        {{ref('stg_smartcollect__sms')}} s
    left join
        {{ref('stg_smartcollect__sms_campaigns')}} sc on s.sms_campaign_id = sc.sms_campaign_id

)

select * from sms_in_campaigns