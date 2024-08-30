{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "stg_resourcetype_coar"
src_pk: "resourcetype_hk"
src_hashdiff: 
  source_column: "resourcetype_hashdiff"
  alias: "hashdiff"
src_payload:
    - label
    - coar
    - label_es
src_ldts: "load_datetime"
src_source: "source"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata_dict["src_pk"],
                   src_hashdiff=metadata_dict["src_hashdiff"],
                   src_payload=metadata_dict["src_payload"],
                   src_ldts=metadata_dict["src_ldts"],
                   src_source=metadata_dict["src_source"],
                   source_model=metadata_dict["source_model"])   }}
