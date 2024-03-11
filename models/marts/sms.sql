
with sms_mart as (
select
    s.sms_id,
    s.case_file_id,
    s.target,
    s.sms_type,
    ap.debtor,
    s.cost,
    s.created_by as user_id,
    u.name as sent_by,
    a.name as approved_by,
    delivery_status,
    sent_at,
    st.template,
    sc.sms_campaign,
    p.product,
    sp.sub_product

from
    {{ ref('int_sms')}} s
inner join {{ ref('int_users')}} u on u.user_id = s.created_by
left join {{ ref('active_portfolio')}} ap on s.case_file_id = ap.id
left join {{ ref('int_users') }} a on a.user_id = s.approved_by
left join {{ ref('int_sms_templates')}} st on s.sms_template_id = st.sms_template_id
left join {{ ref('int_sms_campaigns')}} sc on s.sms_campaign_id = sc.sms_campaign_id
left join {{ ref('int_products')}} as p on st.product_id = p.product_id
left join {{ ref('int_sub_products')}} as sp on st.sub_product_id = sp.sub_product_id
)

select * from sms_mart