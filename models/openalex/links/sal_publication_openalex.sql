with
base as (
    SELECT
        p.internal_identifier,
        d.doi,
        m.mag,
        pmid.pmid,
        pmcid.pmcid,
        p.publication_hk,
        d.doi_hk,
        m.mag_hk,
        pmid.pmid_hk,
        pmcid.pmcid_hk
    FROM {{ ref('stg_publication_openalex')}} stg
    INNER JOIN {{ref('hub_publication_openalex')}} p ON stg.publication_hk = p.publication_hk 
    LEFT JOIN {{ ref('hub_doi_openalex')}} d ON stg.doi_hk = d.doi_hk
    LEFT JOIN {{ ref('hub_mag_openalex')}} m ON stg.mag_hk = m.mag_hk
    LEFT JOIN {{ ref('hub_pmid_openalex')}} pmid ON stg.pmid_hk = pmid.pmid_hk
    LEFT JOIN {{ ref('hub_pmcid_openalex')}} pmcid ON stg.pmcid_hk = pmcid.pmcid_hk
),

final as (
    SELECT * 
    FROM base
)

SELECT * FROM final