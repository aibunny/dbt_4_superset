select
    permission_id,
    role_id
from {{source('smartcollect','permission_role')}}