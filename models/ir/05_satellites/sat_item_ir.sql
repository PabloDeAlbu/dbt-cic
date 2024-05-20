{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: "stg_item_ir"
src_pk: "item_hk"
src_hashdiff: 
  source_column: "item_hashdiff"
  alias: "hashdiff"
src_payload:
    - title
    - subtitle
    - available_date
    - created_date
    - exposure_date
    - publication_date
    - partof
    - volume
    - last_modified
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
