WITH base AS (
    SELECT
    *
    FROM {{ref('sal_publication_openalex')}} sal 
    INNER JOIN {{ref('sat_publication_openalex')}} sat ON sal.publication_hk = sat.publication_hk
),

final AS (
 SELECT
    internal_identifier,
    doi,
    pmcid,
    pmid,
    type,
    language,
    title,
    publication_date,
    issue,
    volume,
    start_page,
    end_page,
    is_paratext,
    display_name,
    has_fulltext,
    is_retracted,
    type_crossref,
    cited_by_count,
    locations_count
 FROM base
)

SELECT * FROM final