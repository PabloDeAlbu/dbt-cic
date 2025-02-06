with base as (
    SELECT 
        type::varchar as openaire_type,
        label_es::varchar as coar_label_es,
        coar_uri::varchar as coar_uri
    FROM {{ref('seed_openaire_resourcetype2coar_resourcetype')}}
)

SELECT * FROM base