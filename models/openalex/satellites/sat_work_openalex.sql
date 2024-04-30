{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "stg_work_openalex"
src_pk: "work_hk"
src_hashdiff: 
  source_column: "work_hashdiff"
  alias: "hashdiff"
src_payload:
  - 'type'
  - 'language'
  - 'title'
  - 'locations'
  - 'publication_date'
  - 'issue'
  - 'volume'
  - 'first_page'
  - 'end_page'
  - 'topics'
  - 'concepts'
  - 'grants'
  - 'apc_list'
  - 'apc_paid'
  - 'indexed_in'
  - 'is_paratext'
  - 'open_access'
  - 'display_name'
  - 'has_fulltext'
  - 'is_retracted'
  - 'related_works'
  - 'type_crossref'
  - 'cited_by_count'
  - 'locations_count'
  - 'referenced_works'
  - '_ab_source_file_url'
  - 'is_authors_truncated'
  - 'referenced_works_count'
  - 'cited_by_percentile_year'
  - 'corresponding_author_ids'
  - 'countries_distinct_count'
  - 'institutions_distinct_count'
  - '_ab_source_file_last_modified'
  - 'corresponding_institution_ids'
  - 'sustainable_development_goals'
  - 'best_oa_location'
src_eff: "EFFECTIVE_FROM"
src_ldts: "LOAD_DATETIME"
src_source: "RECORD_SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata_dict["src_pk"],
                   src_hashdiff=metadata_dict["src_hashdiff"],
                   src_payload=metadata_dict["src_payload"],
                   src_eff=metadata_dict["src_eff"],
                   src_ldts=metadata_dict["src_ldts"],
                   src_source=metadata_dict["src_source"],
                   source_model=metadata_dict["source_model"])   }}
