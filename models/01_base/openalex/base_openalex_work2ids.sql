{{ config(materialized='table')}}

with source as (
        select * from {{ source('openalex', 'work2ids') }}
  ),

renamed as (
    select
        {{ adapter.quote("openalex") }} work_id,
        {{ adapter.quote("doi") }},
        {{ adapter.quote("mag") }},
        {{ adapter.quote("pmcid") }},
        {{ adapter.quote("pmid") }},
        {{ adapter.quote("load_datetime") }}
    from source
),

casted as (
    select
        work_id::varchar,
        doi::varchar,
        mag::varchar,
        pmcid::varchar,
        pmid::varchar,
        {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime
    from renamed
),

fillna as (
    select
        COALESCE(work_id, 'NO DATA') as work_id,
        COALESCE(doi, 'NO DATA') as doi,
        COALESCE(mag, 'NO DATA') as mag,
        COALESCE(pmcid, 'NO DATA') as pmcid,
        COALESCE(pmid, 'NO DATA') as pmid,
        load_datetime
    from casted
),

transformed as (
    select
        work_id,
        split_part(doi, 'https://doi.org/', 2) as doi, -- Extraer solo el DOI
        mag,
        pmcid,
        pmid,
        load_datetime
    from fillna
)

select * from transformed