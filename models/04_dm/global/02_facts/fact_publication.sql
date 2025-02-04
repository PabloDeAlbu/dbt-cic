{{ config(materialized='table') }}

WITH 

{# dspacedb as (
    SELECT
        dspacedb.title,
        dspacedb.doi,
        dspacedb.dateissued
    FROM {{ ref('fact_publication_dspacedb') }} dspacedb
),
 #}
openalex as (
    SELECT
        openalex.work_id,
        openalex.title,
        openalex.openalex_type, 
        openalex.doi,
        openalex.fwci,
        openalex.cited_by_count as cited_by_count_openalex,
        openalex.locations_count as locations_count_openalex,
        openalex.referenced_works_count as referenced_works_count_openalex,
        openalex.publication_year as publication_year_openalex
    FROM {{ ref('fact_publication_openalex') }} openalex
),

openaire as (
    SELECT
        openaire.researchproduct_id,
        openaire.main_title,
        openaire.openaire_type,
        openaire.doi,
        openaire.citation_class as citation_class_openaire,
        openaire.citation_count as citation_count_openaire,
        openaire.impulse as impulse_openaire,
        openaire.impulse_class as impulse_class_openaire,
        openaire.influence as influence_openaire,
        openaire.influence_class as influence_class_openaire,
        openaire.popularity as popularity_openaire,
        openaire.popularity_class as popularity_class_openaire,
        openaire.downloads as downloads_openaire,
        openaire.views as views_openaire
    FROM {{ ref('fact_publication_openaire') }} openaire
),

fact as (
    SELECT
        openaire.researchproduct_id,
        openalex.work_id,
        openaire_type,
        openaire.doi,
        openaire.citation_class_openaire,
        openaire.citation_count_openaire,
        openaire.impulse_openaire,
        openaire.impulse_class_openaire,
        openaire.influence_openaire,
        openaire.influence_class_openaire,
        openaire.popularity_openaire,
        openaire.popularity_class_openaire,
        openaire.downloads_openaire,
        openaire.views_openaire,
        openalex.cited_by_count_openalex,
        openalex.locations_count_openalex,
        openalex.referenced_works_count_openalex,
        openalex.publication_year_openalex,
        COALESCE(openaire.main_title, openalex.title) as title
    FROM openaire
    FULL OUTER JOIN openalex ON openalex.doi = openaire.doi
)

SELECT * FROM fact