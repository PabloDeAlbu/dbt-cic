{# {{ config(materialized='incremental') }} #}
{{ config(materialized='table') }}

{%- set yaml_metadata -%}
source_model: "stg_work_openalex"
src_pk: "work_hk"
src_hashdiff:
  source_column: "work_hashdiff"
  alias: "hashdiff"
src_payload:
      - "id"
      - "type"
      - "language"
      - "title"
      - "publication_date"
      - "issue"
      - "volume"
      - "first_page"
      - "end_page"
      - "doi"
      - "mag"
      - "pmid"
      - "pmcid"
      - "is_paratext"
      - "is_oa"
      - "oa_url"
      - "oa_status"
      - "any_repository_has_fulltext"
      - "display_name"
      - "has_fulltext"
      - "is_retracted"
      - "type_crossref"
      - "cited_by_count"
      - "locations_count"
      - "is_authors_truncated"
      - "referenced_works_count"
      - "cited_by_percentile_year_max"
      - "cited_by_percentile_year_min"
      - "countries_distinct_count"
      - "institutions_distinct_count"
src_eff: "load_datetime"
src_ldts: "load_datetime"
src_source: "source"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata_dict["src_pk"],
                   src_hashdiff=metadata_dict["src_hashdiff"],
                   src_payload=metadata_dict["src_payload"],
                   src_eff=metadata_dict["src_eff"],
                   src_ldts=metadata_dict["src_ldts"],
                   src_source=metadata_dict["src_source"],
                   source_model=metadata_dict["source_model"])   }}
