{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 'base_work2author_openalex'
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
hashed_columns:
  work_hk: work_id
  author_hk: author_id
  work2author_hk:
  - work_id
  - author_id
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
