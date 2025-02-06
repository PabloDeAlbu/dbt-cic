{{ config(materialized='table') }}

{% set identifiers = ["doi", "pmid", "pmc", "arxiv", "handle", "mag"] %}

with base as (
    SELECT
        researchproduct_id::varchar,
        {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime,
        -- Por cada identificador, creamos una columna específica
        {%- for identifier in identifiers %}
        (CASE WHEN pid_id = '{{ identifier }}' THEN pid_text ELSE 'NO DATA' END)::varchar AS {{ identifier }}
        {%- if not loop.last %}, {% endif %}
        {%- endfor %}
    FROM {{ ref('base_openaire_researchproduct2pid') }}
),



final as (
    select * from base
)

select * from final
