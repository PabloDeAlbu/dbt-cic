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
        openalex.coar_label_es,
        openalex.coar_resourcetype_uri,
        openalex.doi,
        openalex.fwci,
        openalex.cited_by_count as cited_by_count_openalex,
        openalex.locations_count as locations_count_openalex,
        openalex.referenced_works_count as referenced_works_count_openalex,
        openalex.publication_year as publication_year_openalex,
        openalex.is_oa as is_oa,
        TRUE as in_openalex,
        FALSE as in_openaire        
    FROM {{ ref('fact_publication_openalex') }} openalex
),

openaire as (
    SELECT
        openaire.researchproduct_id,
        openaire.main_title,
        openaire.coar_label_es,
        openaire.coar_resourcetype_uri,
        openaire.handle,
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
        openaire.views as views_openaire,
        openaire.is_oa as is_oa,
        TRUE as in_openaire,
        FALSE as in_openalex
        
    FROM {{ ref('fact_publication_openaire') }} openaire
),

fact as (
    SELECT
        openaire.researchproduct_id,
        openalex.work_id,
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
        COALESCE(openaire.main_title, openalex.title) as title,
        COALESCE(openaire.is_oa, openalex.is_oa) as is_oa,
        COALESCE(openalex.coar_label_es, openaire.coar_label_es) as coar_label_es,
        COALESCE(openalex.coar_resourcetype_uri, openaire.coar_resourcetype_uri) as coar_resourcetype_uri,
        COALESCE(openaire.in_openaire, openalex.in_openaire) as in_openaire,
        COALESCE(openalex.in_openalex, openaire.in_openalex) as in_openalex
    FROM openaire
    FULL OUTER JOIN openalex ON openalex.doi = openaire.doi
)

SELECT * FROM fact