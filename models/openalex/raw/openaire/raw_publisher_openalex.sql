with base as (
    SELECT
    publisher->>'id' as source_internal_identifier,
    publisher->>'issn' as source_issn,
    publisher->>'type' as source_type,
    publisher->>'is_oa' as source_is_oa,
    publisher->>'issn_l' as source_issn_l,
    publisher->>'is_in_doaj' as source_is_in_doaj,
    publisher->>'display_name' as source_display_name,
    publisher->>'host_organization' as source_host_organization,
    publisher->>'host_organization_lineage' as source_host_organization_lineage,
    publisher->>'host_organization_lineage_names' as source_host_organization_lineage_names
    FROM {{ref('map_publication_publisher_openalex')}}
)

SELECT * FROM base