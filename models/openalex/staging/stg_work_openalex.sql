{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_work_openalex"
derived_columns:
  source: "!OPENALEX"
  load_datetime: _airbyte_extracted_at
  effective_from: publication_date
  start_date: publication_date
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  work_hk: id
  type_hk: type
  work_type_hk:
    - id
    - type
  language_hk: language
  work_language_hk:
    - id
    - language
  doi_hk: doi
  work_doi_hk:
    - id
    - doi
  mag_hk: mag
  work_mag_hk:
    - id
    - mag
  pmid_hk: pmid
  work_pmid_hk:
    - id
    - pmid
  pmcid_hk: pmcid
  work_pmcid_hk:
    - id
    - pmcid
  work_hashdiff:
    is_hashdiff: true
    columns:
      - id
      - type
      - language
      - title
      - publication_date
      - issue
      - volume
      - first_page
      - end_page
      - doi
      - mag
      - pmid
      - pmcid
      - is_paratext
      - is_oai
      - oa_url
      - oa_status
      - any_repository_has_fulltext
      - display_name
      - has_fulltext
      - is_retracted
      - type_crossref
      - cited_by_count
      - locations_count
      - is_authors_truncated
      - referenced_works_count
      - cited_by_percentile_year_max
      - cited_by_percentile_year_min
      - countries_distinct_count
      - institutions_distinct_count

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
