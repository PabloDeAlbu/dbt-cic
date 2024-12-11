{{ config(materialized='table') }}

{% set identifiers =["downloads", "impulse", "influence_alt", "influence", "popularity_alt", "popularity", "views"] %}

with base as (
    SELECT
        researchproduct_id,
        load_datetime,
        -- Por cada identificador, creamos una columna específica
        {%- for identifier in identifiers %}
        (CASE WHEN measure_id = '{{ identifier }}' THEN measure_score ELSE NULL END) AS {{ identifier }},
        {%- endfor %}
        COALESCE(measure_datasource, 'NO DATA') as measure_datasource
    FROM {{ ref('base_openaire_researchproduct2measure') }}
),



final as (
    select * from base
)

select * from final
