{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "norm_researchproduct_openaire"
derived_columns:
  source: "!OPENAIRE"
  load_datetime: load_datetime
  effective_from: date_acceptance
  start_date: date_acceptance
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  researchproduct_hk: researchproduct_id
  researchproduct_hashdiff:
    is_hashdiff: true
    columns:
      - researchproduct_id
      - date_collection
      - date_acceptance
      - description
      - publisher
      - isgreen
      - openaccesscolor
      - isindiamondjournal
      - publiclyfunded
      - load_datetime
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
