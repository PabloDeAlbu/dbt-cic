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
        dim_resourcetype.openaire_resourcetype,
        dim_resourcetype.coar_label,
        dim_resourcetype.coar_label_es,
        dim_resourcetype.coar,
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
    INNER JOIN {{ref('link_researchproduct_resourcetype_openaire')}} link_researchproduct_resourcetype ON sal.researchproduct_hk = link_researchproduct_resourcetype.researchproduct_hk
    INNER JOIN {{ref('dim_resourcetype_openaire')}} dim_resourcetype ON dim_resourcetype.resourcetype_hk = link_researchproduct_resourcetype.resourcetype_hk
),

final AS (
    SELECT
    *
    FROM base
)

SELECT * FROM final