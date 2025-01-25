{{ config(materialized='table') }}

WITH base as (
    SELECT
        work2author.work_hk,
        hub_orcid.orcid
    FROM {{ref('link_work2author_openalex')}} work2author
    INNER JOIN {{ref('hub_work_openalex')}} hub_orcid ON hub_orcid.orcid_hk = work2author.orcid_hk
)

SELECT * FROM base
