WITH 
hub_doi_openalex AS(
	SELECT * FROM stg_openalex.hub_doi_openalex-- 32141
	),

hub_doi_ir AS (
	SELECT * FROM stg_ir.hub_doi_ir -- 23612
),

final AS (
    SELECT doi_hk, doi FROM hub_doi_openalex
    UNION
    SELECT doi_hk, doi FROM hub_doi_ir
    )

SELECT * FROM final