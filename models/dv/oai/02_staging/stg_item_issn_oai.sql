{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 
  'oai': 'item_issn'
derived_columns:
  source: "!OAI"
  load_datetime: load_datetime
hashed_columns:
  handle_hk: handle
  issn_hk: issn
  handle_issn_hk: 
    - handle
    - issn
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
