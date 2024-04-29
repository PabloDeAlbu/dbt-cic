{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_collection_ir"
derived_columns:
  source: "!SEDICI_DB"
hashed_columns:
  collection_hk: "collection_id"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
