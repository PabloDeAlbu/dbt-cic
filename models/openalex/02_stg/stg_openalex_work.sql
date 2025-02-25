{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: "base_openalex_work"
derived_columns:
  source: "!OPENALEX"
  load_datetime: load_datetime
  effective_from: publication_date
  start_date: publication_date
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  work_hk: work_id
  doi_hk: doi
  type_hk: type
  work2type_hk:
    - work_id
    - type
  work_hashdiff:
    is_hashdiff: true
    columns:
      - work_id
      - doi
      - title
      - display_name
      - language
      - type
      - fulltext_origin
      - oa_status
      - oa_url
      - cited_by_api_url
      - any_repository_has_fulltext
      - has_fulltext
      - is_retracted
      - is_paratext
      - countries_distinct_count
      - institutions_distinct_count
      - fwci
      - cited_by_count
      - locations_count
      - referenced_works_count
      - publication_year
      - publication_date
      - updated_date
      - created_date
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
