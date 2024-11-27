{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "norm_openaire_researchproduct2measure"
derived_columns:
  source: "!OPENAIRE"
  load_datetime: load_datetime
hashed_columns:
  researchproduct_hk: id
  attrank_hk: attrank
  cc_hk: cc
  downloads_hk: downloads
  icc_hk: icc
  pr_hk: pr
  ram_hk: ram
  views_hk: views
  researchproduct2measure_hk: 
    - id
    - attrank
    - cc
    - downloads
    - icc
    - pr
    - ram
    - views
  researchproduct2measure_hashdiff:
    is_hashdiff: true
    columns:
      - attrank
      - cc
      - downloads
      - icc
      - pr
      - ram
      - views
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
