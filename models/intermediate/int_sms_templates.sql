with refined_sms_templates as (
    id as sms_template_id,
    title as template,
    target,
    product_id,
    sub_product_id,
    organization_id,
    usage_mode
)

select * from refined_delinquency_reason