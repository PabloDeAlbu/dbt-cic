{{ config(materialized='table') }}

with base as (
    SELECT 
        COALESCE(fact_publication_ir.doi, fact_publication_openalex.doi) AS doi,
        fact_publication_ir.handle,
        fact_publication_openalex.openalex_id,
        COALESCE(fact_publication_ir.title, fact_publication_openalex.title) AS title,
        COALESCE(fact_publication_ir.publication_date, fact_publication_openalex.publication_date) AS publication_date,
        fact_publication_ir.created_date,
        fact_publication_ir.exposure_date,
        fact_publication_ir.partof,
        fact_publication_ir.volume,
        fact_publication_ir.sedici_subtype,
        fact_publication_ir.coar_label_es,
        fact_publication_openalex.openalex_type,
        fact_publication_openalex.coar_label_es as openalex_coar_label_es,
        CASE WHEN fact_publication_openalex.openalex_id is not null THEN True ELSE False END AS isin_openalex,
        CASE WHEN fact_publication_ir.handle is not null THEN True ELSE False END AS isin_ir 
    FROM {{ref('fact_publication_ir')}}
    FULL OUTER JOIN {{ref('fact_publication_openalex')}} ON fact_publication_ir.doi = fact_publication_openalex.doi
),

final as (
    SELECT *
    FROM base
)

select * from final