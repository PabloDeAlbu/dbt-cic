{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "norm_openaire_researchproduct2measure"
derived_columns:
  source: "!OPENAIRE"
  load_datetime: load_datetime
hashed_columns:
  researchproduct_hk: researchproduct_id
  measure_hk: measure_id
  datasource_hk: measure_datasource
  researchproduct2measure_hk:
    - researchproduct_id
    - measure_id
    - measure_datasource
  researchproduct2measure_hashdiff:
    is_hashdiff: true
    columns:
      - researchproduct_id
      - measure_id
      - measure_score
      - measure_class
      - measure_datasource
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
