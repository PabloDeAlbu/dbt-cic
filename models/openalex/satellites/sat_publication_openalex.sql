{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "stg_publication_openalex"
src_pk: "publication_hk"
src_hashdiff: 
  source_column: "publication_hashdiff"
  alias: "hashdiff"
src_payload:
  - 'type'
  - 'language'
  - 'title'
  - 'publication_date'
  - 'issue'
  - 'volume'
  - 'start_page'
  - 'end_page'
  - 'subject'
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
