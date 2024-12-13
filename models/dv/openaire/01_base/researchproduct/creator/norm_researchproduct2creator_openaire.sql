{{ config(materialized='table') }}

with source as (
      select * from {{ ref('base_researchproduct2creator_openaire') }}
),
renamed as (
    select
        researchproduct_id,
        rank,
        name,
        surname,
        text,
        orcid,
        orcid_pending,
        load_datetime
    from source
)
select * from renamed
