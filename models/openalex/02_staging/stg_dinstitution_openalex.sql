{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 
  'openalex': 'dinstitution'
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
hashed_columns:
  dinstitution_hk: id
  ror_hk: ror
  dinstitution_ror_hk:
    - id
    - ror
  type_hk: type
  dinstitution_type:
    - id
    - type
  dinstitution_hashdiff:
    is_hashdiff: true
    columns:
      - id
      - ror
      - display_name
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
