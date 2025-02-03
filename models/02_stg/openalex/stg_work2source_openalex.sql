{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: 'base_work2source_openalex'
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
hashed_columns:
  work_hk: work_id
  source_hk: source_id
  work_source_hk:
    - work_id
    - source_id
  source_type_hk: source_type
  work_source_type:
    - work_id
    - source_type
  source_host_organization_hk: source_host_organization
  work_source_host_organization:
    - work_id
    - source_host_organization
  license_hk: license
  version_hk: version
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
