{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "norm_openaire_researchproduct2pid"
derived_columns:
  source: "!OPENAIRE"
  load_datetime: load_datetime
hashed_columns:
  researchproduct_hk: researchproduct_id
  doi_hk: doi
  pmid_hk: pmid
  pmc_hk: pmc
  arxiv_hk: arxiv
  handle_hk: handle
  mag_hk: mag
  researchproduct2pid_hk: 
    - researchproduct_id
    - doi
    - pmid
    - pmc
    - arxiv
    - handle
    - mag
  researchproduct2pid_hashdiff:
    is_hashdiff: true
    columns:
      - researchproduct_id
      - doi
      - pmid
      - pmc
      - arxiv
      - handle
      - mag

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
