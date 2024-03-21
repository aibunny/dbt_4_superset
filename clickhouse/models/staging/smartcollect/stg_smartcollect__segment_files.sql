select
    case_file_id,
    segment_id
from
    {{source('smartcollect', 'segment_files')}}