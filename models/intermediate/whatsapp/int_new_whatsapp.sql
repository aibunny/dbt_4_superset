{{
    config(
        materialized = 'view' 
    )
}}

with refined_whatsapp as (
    select 
        w.whatsapp_message_id as whatsapp_message_id,
        wc.whatsapp_campaign_id as whatsapp_campaign_id, --TODO:
        w.case_file_id as case_file_id,
        w.organization_id as organization_id,
        w.business_account_id as business_account_id,
        w.message_direction as message_direction,
        w.sender as sender,
        w.sent as whatsapp_message_sent,
        w.message_type as message_type,
        case when w.message_status is null then 'Unknown' else w.message_status end as whatsapp_message_status,
        wc.whatsapp_campaign_name as whatsapp_campaign_name,
        wc.whatsapp_campaign_target as whatsapp_campaign_target,
        wc.runs_from as whatsapp_campaign_runs_from,
        wc.runs_to as whatsapp_campaign_runs_to,
        w.created_at as whatsapp_message_created_at,
        wc.whatsapp_campaign_created_at as whatsapp_campaign_created_at
    from
        {{ref('stg_smartcollect__whatsapp_messages')}} w
    left join
        {{ref('stg_smartcollect__whatsapp_campaigns')}} wc
        on w.whatsapp_campaign_id = whatsapp_campaign_id

    where
        w.created_at >= '{{run_started_at}}'
)

select * from refined_whatsapp