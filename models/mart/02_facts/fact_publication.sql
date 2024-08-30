WITH base as (
    SELECT
        {{ dbt_utils.star(
                from=ref('sal_work_openalex'), 
                except=['work_hk','doi_hk','mag_hk','pmcid_hk','pmid_hk','load_datetime','source']
        )}},
        {{ dbt_utils.star(
            from=ref('sat_work_openalex'), 
            except=['work_hk','hashdiff','load_datetime','source']
        )}},
        hub_doi.doi,
        hub_mag.mag,
        hub_pmcid.pmcid,
        hub_pmid.pmid,
        hub_work_type.work_type_display_name as work_type
    FROM {{ref('sal_work_openalex')}} sal_work
    INNER JOIN {{ref('sat_work_openalex')}} sat_work ON sal_work.work_hk = sat_work.work_hk
    INNER JOIN {{ref('hub_doi_openalex')}} hub_doi ON hub_doi.doi_hk = sal_work.doi_hk
    INNER JOIN {{ref('hub_mag_openalex')}} hub_mag ON hub_mag.mag_hk = sal_work.mag_hk
    INNER JOIN {{ref('hub_pmcid_openalex')}} hub_pmcid ON hub_pmcid.pmcid_hk = sal_work.pmcid_hk
    INNER JOIN {{ref('hub_pmid_openalex')}} hub_pmid ON hub_pmid.pmid_hk = sal_work.pmid_hk
    INNER JOIN {{ref('link_work2work_type_openalex')}} ON link_work2work_type_openalex.work_hk = sal_work.work_hk
    INNER JOIN {{ref('hub_work_type_openalex')}} hub_work_type ON hub_work_type.work_type_hk = link_work2work_type_openalex.work_type_hk
)

SELECT * FROM base
