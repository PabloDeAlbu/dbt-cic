{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_metadatavalue_ir"
derived_columns:
  source: "!SEDICI_DB"
hashed_columns:
  metadatavalue_hk: "metadata_value_id"
  resource_hk: "resource_id"
  resourcetype_hk: "resource_type_id"
  metadatafield_hk: "metadata_field_id"
  authority_hk: "authority"
  metadatavalue_resource_hk:
    - "metadata_value_id"
    - "resource_id"
  metadatavalue_resourcetype_hk:
    - "metadata_value_id"
    - "resource_type_id"
  metadatavalue_metadatafield_hk:
    - "metadata_value_id"
    - "metadata_field_id"
  metadatavalue_authority_hk:
    - "metadata_value_id"
    - "authority"
  metadatavalue_hashdiff:
    is_hashdiff: true
    columns:
      - "metadata_value_id"
      - "authority"
      - "confidence"
      - "text_value"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
