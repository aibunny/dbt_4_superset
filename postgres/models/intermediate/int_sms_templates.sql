with refined_sms_templates as (
    select
        id as sms_template_id,
        title as template,
        target,
        product_id,
        sub_product_id,
        organization_id,
        usage_mode
    from 
        {{ ref('stg_smartcollect__sms_templates')}}
)

select * from refined_sms_templates