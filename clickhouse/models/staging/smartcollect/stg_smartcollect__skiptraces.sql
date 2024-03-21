select
    id as skiptrace_id,
    case_file_id,
    user_id,
    provider as skiptrace_provider,
    is_successful as skiptrace_is_successful,
    failure_reason,
    created_at::timestamp as created_at
from 
    {{ source('smartcollect', 'skiptraces') }}