{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  'oai': 'item'
derived_columns:
  source: "!OAI"
  load_datetime: load_datetime
  effective_from: date_issued
  start_date: date_issued
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  handle_hk: handle
  type_openaire_hk: type_openaire
  handle_type_openaire_hk:
    - handle
    - type_openaire
  type_snrd_hk: type_snrd
  handle_type_snrd_hk:
    - handle
    - type_snrd
  version_hk: version
  access_right_hk: access_right
  access_level_hk: access_level
  license_condition_hk: license_condition
  item_hashdiff:
    is_hashdiff: true
    columns:
      - title
      - title_alternative
      - handle
      - date_issued
      - date_exposure
      - description
      - type_openaire
      - type_snrd
      - version
      - access_right
      - access_level
      - license_condition
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     null_columns=none,
                     hashed_columns=hashed_columns,
                     ranked_columns=none) }}
