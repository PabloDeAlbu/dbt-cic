{{ config(materialized='table') }}

with base as (
    SELECT
        COALESCE(
            ir.doi,
            openaire.doi,
            openalex.doi
        ) AS doi,
        ir.handle,
        openalex.openalex_id,
        openaire.openaire_id,
        openaire.arxiv,
        openaire.ena,
        openaire.pdb,
        openaire.pmc,
        openaire.pmid,
        openaire.uniprot,
        openaire.bestaccessright,
        openaire.dateofacceptance,
        openaire.publisher,
        openaire.resulttype,
        openaire.resourcetype,
        openaire.isgreen,
        openaire.openaccesscolor,
        openaire.isindiamondjournal,
        openaire.publiclyfunded,
        openaire.load_datetime,
        COALESCE(
            ir.title,
            openalex.title
        ) AS title,
        COALESCE(
            ir.publication_date,
            openalex.publication_date
        ) AS publication_date,
        ir.created_date,
        ir.exposure_date,
        ir.partof,
        ir.volume,
        ir.sedici_subtype,
        ir.coar_label_es,
        openalex.openalex_type,
        openalex.coar_label_es as openalex_coar_label_es,
        CASE WHEN ir.handle is not null THEN True ELSE False END AS isin_ir,
        CASE WHEN openalex.openalex_id  is not null THEN True ELSE False END AS isin_openalex,
        CASE WHEN openaire.openaire_id  is not null THEN True ELSE False END AS isin_openaire
        FROM {{ref('fact_publication_ir')}} ir
    FULL OUTER JOIN {{ref('fact_publication_openalex')}} openalex ON ir.doi = openalex.doi
    FULL OUTER JOIN {{ref('fact_publication_openaire')}} openaire ON ir.doi = openaire.doi
),

final as (
    SELECT *
    FROM base
)

select * from final