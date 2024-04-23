{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "typed_publication_ir"
derived_columns:
  source: "!REPOSITORY_DB"
  load_datetime: _airbyte_extracted_at
  effective_from: available_date
  start_date: _airbyte_extracted_at
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  publication_hk: internal_identifier
  handle_hk: handle
  doi_hk: doi
  publication_hashdiff:
    is_hashdiff: true
    columns:
      - title
      - type
      - subtype
      - available_date
      - created_date
      - exposure_date
      - publication_date
      - language
      - license_uri
      - partof
      - subtitle
      - volume
      - last_modified
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
