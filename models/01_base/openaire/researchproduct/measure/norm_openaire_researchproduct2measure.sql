{{ config(materialized='table') }}

with base as (
      select * from {{ ref('base_openaire_researchproduct2measure') }}
),
renamed as (
    select
        researchproduct_id,
        COALESCE(measure_id, 'NO DATA') as measure_id,
        -- TODO fillna measure_score
        measure_score,
        COALESCE(measure_class, 'NO DATA') as measure_class,
        COALESCE(measure_datasource, 'NO DATA') as measure_datasource,
        load_datetime
    from base
)
select * from renamed