{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 
  'openalex': 'work2authorship'
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
hashed_columns:
  work_hk: work_id
  author_hk: author_id
  work2author_hk:
    - work_id
    - author_id
  orcid_hk: author_orcid
  author2orcid_hk:
    - author_id
    - author_orcid
  institution_hk: institution_id
  work_institution_hk:
    - work_id
    - institution_id
  ror_hk: institution_ror
  institution2ror_hk:
    - institution_id
    - institution_ror
  author_hashdiff:
    is_hashdiff: true
    columns:
      - author_display_name
  institution_hashdiff:
    is_hashdiff: true
    columns:
      - institution_display_name
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
