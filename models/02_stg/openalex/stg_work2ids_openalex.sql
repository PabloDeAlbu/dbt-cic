{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 'base_openalex_work2ids'
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
hashed_columns:
  work_hk: work_id
  doi_hk: doi
  mag_hk: mag
  pmcid_hk: pmcid
  pmid_hk: pmid
  work2ids_hk:
    - work_id
    - doi
    - mag
    - pmcid
    - pmid
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
