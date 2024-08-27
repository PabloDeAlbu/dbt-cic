with base as (
    SELECT
        hub_work_openalex.work_hk,
        hub_work_openalex.work_id,
        hub_doi_openalex.doi,
        hub_mag_openalex.mag,
        hub_pmcid_openalex.pmcid,
        hub_pmid_openalex.pmid
    FROM {{ref('hub_work_openalex')}}
    LEFT JOIN {{ref('link_work2doi_openalex')}} ON hub_work_openalex.work_hk = link_work2doi_openalex.work_hk
    LEFT JOIN {{ref('hub_doi_openalex')}} ON hub_doi_openalex.doi_hk = link_work2doi_openalex.doi_hk
    LEFT JOIN {{ref('link_work2mag_openalex')}} ON hub_work_openalex.work_hk = link_work2mag_openalex.work_hk
    LEFT JOIN {{ref('hub_mag_openalex')}} ON hub_mag_openalex.mag_hk = link_work2mag_openalex.mag_hk
    LEFT JOIN {{ref('link_work2pmcid_openalex')}} ON hub_work_openalex.work_hk = link_work2pmcid_openalex.work_hk
    LEFT JOIN {{ref('hub_pmcid_openalex')}} ON hub_pmcid_openalex.pmcid_hk = link_work2pmcid_openalex.pmcid_hk
    LEFT JOIN {{ref('link_work2pmid_openalex')}} ON hub_work_openalex.work_hk = link_work2pmid_openalex.work_hk
    LEFT JOIN {{ref('hub_pmid_openalex')}} ON hub_pmid_openalex.pmid_hk = link_work2pmid_openalex.pmid_hk
)

SELECT * FROM base