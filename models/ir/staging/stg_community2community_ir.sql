{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_community2community_ir"
derived_columns:
  source: "!SEDICI_DB"
hashed_columns:
  community_hk: "id"
  child_hk: "child_comm_id"
  parent_hk: "parent_comm_id"
  community_child_hk:
    - "id"
    - "child_comm_id"
  community_parent_hk:
    - "id"
    - "parent_comm_id"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
