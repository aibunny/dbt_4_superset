select
    id as notification_id,
    type as notification_type,
    notifiable_type,
    notifiable_id,
    organization_id,
    title as notification_title,
    content as notification_content,
    extra_attributes as notification_extra_attributes,
    read_at::timestamp as notification_read_at,
    created_by as notification_created_by,
    updated_by as notification_updated_by,
    created_at::timestamp as notification_created_at,
    updated_at::timestamp as notification_updated_at
from
    {{ source('smartcollect', 'notifications') }}