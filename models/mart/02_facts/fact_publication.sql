{{ config(materialized='table') }}

WITH base as (
    SELECT
        COALESCE(dspacedb.title, openalex.title) as title,
        COALESCE(dspacedb.doi, openalex.doi) as doi,
        COALESCE(dspacedb.dateissued, openalex.publication_date) as publication_date
    FROM {{ ref('fact_publication_dspacedb') }} dspacedb
    LEFT JOIN {{ ref('fact_publication_openalex') }} openalex ON openalex.doi = dspacedb.doi
),

add_openaire as (
    SELECT
        base.title,
        base.doi,
        openaire.attrank,
        openaire.cc,
        openaire.downloads,
        openaire.icc,
        openaire.pr,
        openaire.ram,
        openaire.views
    FROM base
    LEFT JOIN {{ ref('fact_publication_openaire') }} openaire ON openaire.doi = base.doi
),

fact as (
    SELECT 
        add_openaire.title,
        add_openaire.doi,
        add_openaire.attrank,
        add_openaire.cc,
        add_openaire.downloads,
        add_openaire.icc,
        add_openaire.pr,
        add_openaire.ram,
        add_openaire.views,
        dim_doi.in_dspacedb,
        dim_doi.in_openaire,
        dim_doi.in_openalex
    FROM add_openaire
    LEFT JOIN {{ ref('dim_doi') }} ON dim_doi.doi = add_openaire.doi
)

SELECT * FROM fact