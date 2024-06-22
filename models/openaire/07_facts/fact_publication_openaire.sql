WITH base AS (
    SELECT 
        sal.id as openaire_id,
        sal.arxiv,
        sal.doi,
        sal.ena,
        sal.pdb,
        sal.pmc,
        sal.pmid,
        sal.uniprot,
        sat.bestaccessright,
        sat.dateofacceptance,
        sat.publisher,
        sat.resulttype,
        sat.resourcetype,
        sat.isgreen,
        sat.openaccesscolor,
        sat.isindiamondjournal,
        sat.publiclyfunded,
        sal.load_datetime
    FROM {{ref('sal_researchproduct_openaire')}} sal
    INNER JOIN {{ref('sat_researchproduct_openaire')}} sat ON sal.researchproduct_hk = sat.researchproduct_hk
),

final AS (
    SELECT
    *
    FROM base
)

SELECT * FROM final