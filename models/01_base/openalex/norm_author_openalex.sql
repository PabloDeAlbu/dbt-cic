{{ config(materialized='table')}}

with base as (
    select
        author_id::varchar,
        COALESCE(orcid, 'NO DATA')::varchar as orcid,
        COALESCE(display_name, 'NO DATA')::varchar as display_name,
        works_count::int,
        cited_by_count::int,
        {{ dbt_date.convert_timezone("updated_date") }} as updated_date,
        {{ dbt_date.convert_timezone("created_date") }} as created_date,
        {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime
    from {{ ref('base_cic_author_openalex') }}
)
select * from base
  