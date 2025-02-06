{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 'base_author2institution_openalex'
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
hashed_columns:
  author_hk: author_id
  institution_hk: institution_id
  ror_hk: ror
  author_institution_hk:
    - author_id
    - institution_id
    - ror
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
