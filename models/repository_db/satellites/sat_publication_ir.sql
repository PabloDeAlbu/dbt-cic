{# {{ config(materialized='incremental') }} #}

{%- set yaml_metadata -%}
source_model: "stg_publication_ir"
src_pk: "publication_hk"
src_hashdiff: 
  source_column: "publication_hashdiff"
  alias: "hashdiff"
src_payload:
    - title
    - type
    - subtype
    - available_date
    - created_date
    - exposure_date
    - language
    - license_uri
    - partof
    - publication_date
    - subtitle
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
