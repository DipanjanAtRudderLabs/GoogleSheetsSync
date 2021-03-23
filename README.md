# Companion DBT project for Google Sheet to data warehouse sync using RudderStack

This project can be used to generate the latest snapshot for Google Sheets data that is sync-ed to a data warehouse using RudderStack.

RudderStack Google Sheets Source performs a complete extraction of the sheet data for every sync run.

Thus, when such a Source is connected to a data warehouse Destination (e.g. Snowflake) - the resulting table **_rows** ends up with multiple records for the same row in Google Sheets.

This DBT project generates a *latest snapshot* table from the **_rows** table which reflects the latest state of the data as it has been sync-ed from Google Sheets.

## How does it work

Every extract performed by the Google Sheets sync is associated with a **context_sources_job_id** and a **context_sources_job_run_id**.

For the same sheet, the **context_sources_job_id** remains the same and the **context_sources_job_run_id** keeps getting changed.

The code works by identifying the **latest** combination of the two fields mentioned above. 

This is done by 

* calculating the **minimum** or *start* time for every run (i.e. every job_id/job_run_id combo) 
* performing **rank()** operation on the start times with the start times in descending order i.e. latest first
* taking the job_id/job_run_id cobination which has rank = 1

### How to use the project

* dbt run --full-refresh

**full-refresh** is required since we need to build the target snapshot table afresh every time to ensure that only latest records are there in that table


### Resources:
- Learn more about RudderStack (https://rudderstack.com)
- Documentation (https://docs.rudderstack.com/)
- Open Source (https://github.com/rudderlabs)
