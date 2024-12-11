{{ config(materialized='table') }}

{% set date_id = ["accepted", "created", "issued", "published_online", "published_print", "submitted", "updated"] %}

with base as (
    SELECT
        researchproduct_id,
        -- Por cada identificador, creamos una columna específica
        {%- for identifier in date_id %}
        (CASE WHEN date_id = '{{ identifier }}' THEN date_text ELSE 'NO DATA' END) AS {{ identifier }}
        {%- if not loop.last %}, {% endif %}
        {%- endfor %}
    FROM {{ ref('base_openaire_researchproduct2relevantdate') }}
),



final as (
    select * from base
)

select * from final
