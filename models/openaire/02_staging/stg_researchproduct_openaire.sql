{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_researchproduct_openaire"
derived_columns:
  source: "!OPENAIRE"
  load_datetime: load_datetime
  effective_from: dateofacceptance
  start_date: dateofacceptance
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  researchproduct_hk: id
  doi_hk: doi
  pmid_hk: pmid
  pmc_hk: pmc
  arxiv_hk: arxiv
  uniprot_hk: uniprot
  ena_hk: ena
  pdb_hk: pdb
  researchproduct_doi_hk:
    - id
    - doi
  researchproduct_pmid_hk:
    - id
    - pmid
  researchproduct_pmc_hk:
    - id
    - pmc
  researchproduct_arxiv_hk:
    - id
    - arxiv
  researchproduct_uniprot_hk:
    - id
    - uniprot
  researchproduct_ena_hk:
    - id
    - ena
  researchproduct_pdb_hk:
    - id
    - pdb
  researchproduct_hashdiff:
    is_hashdiff: true
    columns:
      - bestaccessright
      - dateofacceptance
      - publisher
      - resulttype
      - resourcetype
      - isgreen
      - openaccesscolor
      - isindiamondjournal
      - publiclyfunded
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
