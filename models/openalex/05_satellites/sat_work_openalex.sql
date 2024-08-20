{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "stg_work_openalex"
src_pk: "work_hk"
src_hashdiff:
  source_column: "work_hashdiff"
  alias: "hashdiff"
src_payload:
  - id
  - doi
  - title
  - display_name
  - publication_year
  - publication_date
  - language
  - type
  - countries_distinct_count
  - institutions_distinct_count
  - fwci
  - has_fulltext
  - fulltext_origin
  - cited_by_count
  - is_retracted
  - is_paratext
  - locations_count
  - referenced_works_count
  - updated_date
  - created_date
  - mag
  - openalex
  - pmcid
  - pmid
  - any_repository_has_fulltext
  - is_oa
  - oa_status
  - oa_url
  - cited_by_percentile_year_max
  - cited_by_percentile_year_min
  - citation_normalized_percentile_is_in_top_10_percent
  - citation_normalized_percentile_is_in_top_1_percent
  - citation_normalized_percentile_value
  - primary_location_source_id
  - apc_list_currency
  - apc_list_provenance
  - apc_list_value
  - apc_list_value_usd
  - apc_paid_currency
  - apc_paid_provenance
  - apc_paid_value
  - apc_paid_value_usd
  - primary_topic_id
  - indexed_in_arxiv
  - indexed_in_doaj
  - indexed_in_crossref
  - indexed_in_pubmed
src_eff: "load_datetime"
src_ldts: "load_datetime"
src_source: "source"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata_dict["src_pk"],
                   src_hashdiff=metadata_dict["src_hashdiff"],
                   src_payload=metadata_dict["src_payload"],
                   src_eff=metadata_dict["src_eff"],
                   src_ldts=metadata_dict["src_ldts"],
                   src_source=metadata_dict["src_source"],
                   source_model=metadata_dict["source_model"])   }}
