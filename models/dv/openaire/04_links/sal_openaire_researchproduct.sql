{{ config(materialized='incremental') }}

{%- set source_model = "stg_openaire_researchproduct2pid" -%}
{%- set src_pk = "sal_researchproduct_hk" -%}
{%- set src_fk = ["researchproduct_hk","doi_hk", "mag_hk", "pmid_hk", "pmc_hk", "arxiv_hk", "handle_hk"] -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "source" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
