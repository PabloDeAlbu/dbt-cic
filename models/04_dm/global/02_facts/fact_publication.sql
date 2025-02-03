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
        openalex.doi
    FROM {{ ref('fact_publication_openalex') }} openalex
),

openaire as (
    SELECT
        openaire.researchproduct_id,
        openaire.doi
    FROM {{ ref('fact_publication_openaire_graph') }} openaire
),

fact as (
    SELECT
        openaire.researchproduct_id,
        openalex.work_id,
        openaire.doi
    FROM openaire
    FULL OUTER JOIN openalex ON openalex.doi = openaire.doi
)

SELECT * FROM fact