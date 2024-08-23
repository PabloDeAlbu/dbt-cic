{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "stg_item_oai"
src_pk: "handle_hk"
src_hashdiff: 
  source_column: "item_hashdiff"
  alias: "hashdiff"
src_payload:
    - title
    - title_alternative
    - handle
    - date_issued
    - date_exposure
    - description
    - type_openaire
    - type_snrd
    - version
    - access_right
    - access_level
    - license_condition
src_eff: "effective_from"
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
