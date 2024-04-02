select
    case_file_id,
    segment_id
from
    {{source(var('source_db'), 'segment_files')}}