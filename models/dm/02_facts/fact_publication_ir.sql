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

dspacedb as (
    SELECT
        dspacedb.title,
        dspacedb.doi,
        dspacedb.handle,
        dspacedb.coar_label_es,
        dspacedb.coar_resourcetype_uri
    FROM {{ ref('fact_publication_dspace5') }} dspacedb
),

openaire as (
    SELECT
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
        openaire.is_oa as is_oa
    FROM {{ ref('fact_publication_openaire') }} openaire
),

fact as (
    SELECT
        COALESCE(dspacedb.title, openaire.main_title) as title,
        COALESCE(dspacedb.coar_label_es, openaire.coar_label_es) as coar_label_es,
        openaire.coar_resourcetype_uri,
        openaire.handle,
        COALESCE(dspacedb.doi, openaire.doi) as doi,
        openaire.handle,
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
        openaire.views_openaire
    FROM dspacedb
    INNER JOIN openaire ON openaire.handle = dspacedb.handle
)

SELECT * FROM fact