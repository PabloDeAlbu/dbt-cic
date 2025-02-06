-- FIXME
{{ config(materialized='table') }}

with source as (
      select * from {{ source('openaire', 'researchproduct2measure') }}
),
renamed as (
    select
        {{ adapter.quote("dri:objIdentifier") }} as researchproduct_id,
        {{ adapter.quote("@id") }} as measure_id,
        {{ adapter.quote("@score") }}::float as measure_score,
        {{ adapter.quote("@class") }} as measure_class,
        {{ adapter.quote("@datasource") }} measure_datasource,
        {{ adapter.quote("load_datetime") }}
    from source
),

base as (
    select
        researchproduct_id,
        SUM(CASE WHEN measure_id = 'impulse' THEN measure_score ELSE 0 END) AS impulse,
        (CASE WHEN measure_id = 'impulse' THEN measure_class ELSE 'NO DATA' END) AS impulse_class,
        SUM(CASE WHEN measure_id = 'influence_alt' THEN measure_score ELSE 0 END) AS influence_alt,
        (CASE WHEN measure_id = 'influence_alt' THEN measure_class ELSE 'NO DATA' END) AS influence_alt_class,
        SUM(CASE WHEN measure_id = 'impulse' THEN measure_score ELSE 0 END) AS popularity,
        (CASE WHEN measure_id = 'impulse' THEN measure_class ELSE 'NO DATA' END) AS popularity_class,
        SUM(CASE WHEN measure_id = 'popularity_alt' THEN measure_score ELSE 0 END) AS popularity_alt,
        (CASE WHEN measure_id = 'popularity_alt' THEN measure_class ELSE 'NO DATA' END) AS popularity_alt_class,
        SUM(CASE WHEN measure_id = 'influence' THEN measure_score ELSE 0 END) AS influence,
        (CASE WHEN measure_id = 'influence' THEN measure_class ELSE 'NO DATA' END) AS influence_class,
        SUM(CASE WHEN measure_id = 'downloads' THEN measure_score ELSE 0 END) AS downloads,
        SUM(CASE WHEN measure_id = 'views' THEN measure_score ELSE 0 END) AS views,
        COALESCE(measure_datasource, 'NO DATA') as measure_datasource,
        load_datetime
    from renamed
    GROUP BY researchproduct_id, load_datetime, measure_datasource, impulse_class, influence_alt_class, popularity_alt_class, influence_class
    ORDER BY 1
)

select * from base
--select * from renamed