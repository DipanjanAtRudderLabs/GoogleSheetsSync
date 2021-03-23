select
    context_sources_job_id,
    context_sources_job_run_id,
    min(timestamp) as run_start_ts,
    rank() over (order by run_start_ts desc) as rank
  from
    {{ source('google_sheets_sync','_rows') }}
  group by
    context_sources_job_id, context_sources_job_run_id