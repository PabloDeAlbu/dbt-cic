{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_item_ir"
derived_columns:
  source: "!SEDICI_DB"
  load_datetime: "load_datetime"
  effective_from: "last_modified"
  start_date: "last_modified"
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  item_hk: "item_id"
  submitter_hk: "submitter_id"
  collection_hk: "owning_collection"
  item_submitter_hk:
    - "item_id"
    - "submitter_id"
  item_collection_hk:
    - "item_id"
    - "owning_collection"
  item_hashdiff:
    is_hashdiff: true
    columns:
      - "item_id"
      - "last_modified"
      - "owning_collection"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
