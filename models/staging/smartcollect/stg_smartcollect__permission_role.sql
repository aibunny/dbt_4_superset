select
    permission_id,
    role_id
from {{source(var('source_db'),'permission_role')}}