{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_community2item_ir"
derived_columns:
  source: "!SEDICI_DB"
hashed_columns:
  item_hk: "item_id"
  community_hk: "community_id"
  item_community_hk:
    - "item_id"
    - "community_id"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
