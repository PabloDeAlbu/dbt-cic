{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 'raw_resourcetype_coar'
derived_columns:
  source: "!SEED"
  load_datetime: load_datetime
hashed_columns:
  resourcetype_hk: resourcetype_id
  resourcetype_hashdiff:
    is_hashdiff: true
    columns:
      - resourcetype_id
      - label
      - parent_label_1
      - parent_label_2
      - parent_label_3
      - label_es
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     null_columns=none,
                     hashed_columns=hashed_columns,
                     ranked_columns=none) }}
