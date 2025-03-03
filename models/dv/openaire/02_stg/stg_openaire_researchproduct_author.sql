{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "final_openaire_researchproduct_author"
derived_columns:
  source: "!OPENAIRE"
  load_datetime: load_datetime
hashed_columns:
  researchproduct_hk: researchproduct_id
  author_hk: author_id
  researchproduct_author_hk:
    - researchproduct_id
    - pid
  author_hashdiff:
    is_hashdiff: true
    columns:
      - researchproduct_id
      - full_name
      - name
      - pid
      - rank
      - surname

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
