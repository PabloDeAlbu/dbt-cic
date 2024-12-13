{{ config(materialized='table') }}

{% set subject_id = ["agrovoc", "ddc", "fos", "keyword", "lcsh", "sdg", "subjectmag"] %}

with base as (
    SELECT
        researchproduct_id,
        -- Por cada identificador, creamos una columna específica
        {%- for identifier in subject_id %}
        (CASE WHEN subject_id = '{{ identifier }}' THEN subject_text ELSE 'NO DATA' END) AS {{ identifier }}
        {%- if not loop.last %}, {% endif %}
        {%- endfor %}
    FROM {{ ref('base_researchproduct2subject_openaire') }}
),



final as (
    select * from base
)

select * from final
