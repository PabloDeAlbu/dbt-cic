{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_publication_openalex"
derived_columns:
  source: "!OPENALEX"
  load_datetime: _airbyte_extracted_at
  {# TODO se debería usar algo como https://docs.openalex.org/api-entities/works/work-object#created_date en effective_from  #}
  {# effective_from: _airbyte_extracted_at
  start_date: _airbyte_extracted_at
  end_date: to_date('9999-12-31', 'YYYY-MM-DD') #}
hashed_columns:
  publication_hk: internal_identifier
  doi_hk: doi
  mag_hk: mag
  pmid_hk: pmid
  pmcid_hk: pmcid
  type_hk: type
  publication_type_hk:
    - internal_identifier
    - type
  language_hk: language
  publication_language_hk:
    - internal_identifier
    - language
  publication_hashdiff:
    is_hashdiff: true
    columns:
        - type
        - language
        - title
        - publication_date
        - issue
        - volume
        - start_page
        - end_page
        - grants
        - apc_list
        - apc_paid
        - indexed_in
        - is_paratext
        - open_access
        - display_name
        - has_fulltext
        - is_retracted
        - related_works
        - type_crossref
        - cited_by_count
        - locations_count
        - referenced_works
        - _ab_source_file_url
        - is_authors_truncated
        - referenced_works_count
        - cited_by_percentile_year
        - corresponding_author_ids
        - countries_distinct_count
        - institutions_distinct_count
        - _ab_source_file_last_modified
        - corresponding_institution_ids
        - sustainable_development_goals
        - best_oa_location
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

