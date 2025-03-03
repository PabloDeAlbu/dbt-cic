WITH base as (
    SELECT 
        type::varchar as openalex_type,
        label_es::varchar as coar_label_es,
        coar_uri::varchar as coar_uri
    FROM {{ref('seed_openalex_worktype2coar_types')}}
)

SELECT * FROM base