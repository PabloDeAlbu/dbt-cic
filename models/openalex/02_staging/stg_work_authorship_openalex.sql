{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 
  'openalex': 'work_authorship'
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
hashed_columns:
  work_hk: id
  dauthor_hk: author_id
  work_dauthor_hk:
    - id
    - author_id
  dinstitution_hk: institution_id
  work_dinstitution_hk:
    - id
    - institution_id
  work_authorship_hashdiff:
    is_hashdiff: true
    columns:
      - author_display_name
      - author_position
      - is_corresponding
      - institution_display_name
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
