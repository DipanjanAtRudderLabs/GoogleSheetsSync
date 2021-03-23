select 
    a.* 
from 
    {{ source('google_sheets_sync','_rows')}} a,
    {{ ref('dbt_run_start_timestamp_table') }} b
where
    b.rank = 1
and 
    a.context_sources_job_id = b.context_sources_job_id
and
    a.context_sources_job_run_id = b.context_sources_job_run_id