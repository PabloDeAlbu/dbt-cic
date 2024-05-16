with base as (
    SELECT
        hub_work_openalex.work_hk,
        hub_work_openalex.id,
        hub_doi_openalex.doi,
        hub_mag_openalex.mag,
        hub_pmcid_openalex.pmcid,
        hub_pmid_openalex.pmid
        {# hub_language_openalex.language,
        hub_type_openalex.type #}
    FROM {{ref('hub_work_openalex')}}
    LEFT JOIN {{ref('link_work_doi_openalex')}} ON hub_work_openalex.work_hk = link_work_doi_openalex.work_hk
    LEFT JOIN {{ref('hub_doi_openalex')}} ON hub_doi_openalex.doi_hk = link_work_doi_openalex.doi_hk
    LEFT JOIN {{ref('link_work_mag_openalex')}} ON hub_work_openalex.work_hk = link_work_mag_openalex.work_hk
    LEFT JOIN {{ref('hub_mag_openalex')}} ON hub_mag_openalex.mag_hk = link_work_mag_openalex.mag_hk
    LEFT JOIN {{ref('link_work_pmcid_openalex')}} ON hub_work_openalex.work_hk = link_work_pmcid_openalex.work_hk
    LEFT JOIN {{ref('hub_pmcid_openalex')}} ON hub_pmcid_openalex.pmcid_hk = link_work_pmcid_openalex.pmcid_hk
    LEFT JOIN {{ref('link_work_pmid_openalex')}} ON hub_work_openalex.work_hk = link_work_pmid_openalex.work_hk
    LEFT JOIN {{ref('hub_pmid_openalex')}} ON hub_pmid_openalex.pmid_hk = link_work_pmid_openalex.pmid_hk
    {# LEFT JOIN {{ref('link_work_language_openalex')}} ON hub_work_openalex.work_hk = link_work_language_openalex.work_hk
    LEFT JOIN {{ref('hub_language_openalex')}} ON hub_language_openalex.language_hk = link_work_language_openalex.language_hk
    LEFT JOIN {{ref('link_work_type_openalex')}} ON hub_work_openalex.work_hk = link_work_type_openalex.work_hk
    LEFT JOIN {{ref('hub_type_openalex')}} ON hub_type_openalex.type_hk = link_work_type_openalex.type_hk #}
)

SELECT * FROM base