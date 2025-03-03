{{ config(materialized='table') }}

WITH 

openalex as (
    SELECT
        *
    FROM {{ ref('fact_openalex_work') }} openalex
),

hub_openaire_doi as (
    SELECT * 
    FROM {{ref('hub_openaire_doi')}} 
),

final as (
    SELECT 
        openalex.*
    FROM openalex
    INNER JOIN hub_openaire_doi ON openalex.doi =  hub_openaire_doi.doi
)

select * FROM final