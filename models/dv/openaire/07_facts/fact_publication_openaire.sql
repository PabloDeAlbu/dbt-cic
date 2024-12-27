{{ config(materialized='table') }}

WITH base as (
    SELECT
        CONCAT('https://api.openaire.eu/search/researchProducts?resultID=', dim_pid.researchproduct_id) openaire_url,
        sat.date_collection,
        sat.date_acceptance,
        {# sat.description, #}
        sat.publisher,
        sat.isgreen,
        sat.openaccesscolor,
        sat.isindiamondjournal,
        sat.publiclyfunded,
        {# sat.downloads,
        sat.impulse,
        sat.influence_alt,
        sat.influence,
        sat.popularity_alt,
        sat.popularity, #}
        COALESCE(dim_downloads.total_downloads, 0) as total_downloads,
        COALESCE(dim_views.total_views, 0) as total_views,
        COALESCE(dim_attrank.attrank, 0) as attrank,
        COALESCE(dim_citation.citation_count, 0) as citation_count,
        COALESCE(dim_incubation_citation_count.incubation_citation_count, 0) as incubation_citation_count,
        COALESCE(dim_pagerank.pagerank, 0) as pagerank,
        COALESCE(dim_ram.ram, 0) as ram,
        dim_pid.arxiv,
        dim_pid.doi,
        dim_pid.handle,
        dim_pid.mag,
        dim_pid.pmc,
        dim_pid.pmid,
        dim_date_issued.date_text as date_issued
    FROM {{ref('sal_researchproduct_openaire')}} sal
    INNER JOIN {{ref('sat_researchproduct_openaire')}} sat ON sat.researchproduct_hk = sal.researchproduct_hk
    INNER JOIN {{ref('dim_pid_openaire')}} dim_pid ON dim_pid.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_attrank_openaire')}} dim_attrank ON dim_attrank.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_citation_count_openaire')}} dim_citation ON dim_citation.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_date_issued_openaire')}} dim_date_issued ON dim_date_issued.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_downloads_openaire')}} dim_downloads ON dim_downloads.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_incubation_citation_count_openaire')}} dim_incubation_citation_count ON dim_incubation_citation_count.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_pagerank_openaire')}} dim_pagerank ON dim_pagerank.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_ram_openaire')}} dim_ram ON dim_ram.researchproduct_hk = sal.researchproduct_hk
    LEFT JOIN {{ref('dim_views_openaire')}} dim_views ON dim_views.researchproduct_hk = sal.researchproduct_hk
)

SELECT * FROM base
