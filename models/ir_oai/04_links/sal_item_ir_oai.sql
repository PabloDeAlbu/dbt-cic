WITH base AS (
    SELECT 
    hub_handle.handle_hk,
    hub_doi.doi,
    hub_handle.handle
    FROM {{ref('hub_handle_ir_oai')}} hub_handle
    LEFT JOIN {{ref('link_handle_doi_ir_oai')}} link_handle_doi ON link_handle_doi.handle_hk = hub_handle.handle_hk
    LEFT JOIN {{ref('hub_doi_ir_oai')}} hub_doi ON hub_doi.doi_hk = link_handle_doi.doi_hk
)

SELECT * FROM base