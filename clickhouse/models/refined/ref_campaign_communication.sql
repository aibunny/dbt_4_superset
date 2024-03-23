with campaign_communication as (

    select
        cc.organization_id as organization_id,
        cc.call_id as call_id,
        cc.user_id as call_user_id, ---user making the call
        cc.case_file_id as call_case_file_id,
        cc.call_from as call_from,
        cc.call_to as call_to,
        cc.call_ring_time_seconds as call_ring_time_seconds,
        cc.call_talk_time_in_seconds as call_talk_time_in_seconds,
        cc.destination_trunk_name as  call_destination_trunk_name,
        cc.source_trunk_name as call_source_trunk_name,
        cc.call_status as call_status, --answered/ no answer/ busy
        cc.call_type as call_type, --inbound/outbound
        cc.agent_ring_time as agent_ring_time,
        cc.call_made_at as call_made_at,
        cc.call_rating as call_rating,
        cc.call_campaign_id as call_campaign_id,
        cc.call_campaign_name as call_campaign_name,
        cc.call_campaign_end_date_time as call_campaign_end_date_time,
        cc.call_campaign_start_date_time as call_campaign_start_date_time,
        cc.call_campaign_dial_mode as call_campaign_dial_mode,
        cc.call_campaign_created_at as call_campaign_created_at,
        
        mc.mail_id as mail_id,
        mc.mail_subject as mail_subject,
        mc.case_file_id as mail_case_file_id,
        mc.user_id as mail_user_id,
        mc.campaign_batch_id as mail_campaign_batch_id,
        mc.mail_scheduled_at as mail_scheduled_at,
        mc.mail_sent_at as mail_sent_at,
        mc.mail_campaign_name as mail_campaign_name,
        mc.mail_campaign_target as mail_campaign_target, --guarantor/debtor
        mc.mail_campaign_created_at as mail_campaign_created_at,
        mc.mail_campaign_end_date as mail_campaign_end_date,

        sc.sms_id as sms_id,
        sc.case_file_id as sms_case_file_id,
        sc.user_id as sms_user_id,
        sc.moderator as sms_moderator,
        sc.sms_type as sms_type, --Bulk/single
        sc.scheduled_at as sms_scheduled_at,
        sc.sms_approved as sms_approved,
        sc.delivery_status as delivery_status,
        sc.sms_sent as sms_sent,
        sc.sms_sent_at as sent_at,
        sc.sms_campaign_name as sms_campaign_name,
        sc.sms_campaign_target as sms_campaign_target,
        sc.sms_campaign_end_date as sms_campaign_end_date,
        sc.sms_campaign_created_at as sms_campaign_created_at
    
    from {{ref('int_calls_in_campaigns')}} cc
    full outer join {{ref('int_mail_in_campaigns')}} mc  on  cc.organization_id = mc.organization_id
    full outer join {{ref('int_sms_in_campaigns')}} sc on  cc.organization_id = sc.organization_id
)

select * from campaign_communication