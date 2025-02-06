{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "stg_work_openalex"
src_pk: "work_hk"
src_hashdiff:
  source_column: "work_hashdiff"
  alias: "hashdiff"
src_payload:
  - work_id
  - doi
  - title
  - display_name
  - language
  - type
  - fulltext_origin
  - oa_status
  - oa_url
  - cited_by_api_url
  - any_repository_has_fulltext
  - has_fulltext
  - is_retracted
  - is_paratext
  - countries_distinct_count
  - institutions_distinct_count
  - fwci
  - cited_by_count
  - locations_count
  - referenced_works_count
  - publication_year
  - publication_date
  - updated_date
  - created_date
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
