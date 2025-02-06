{{ config(materialized='incremental') }}

{%- set source_model = "stg_researchproduct2date_openaire" -%}
{%- set src_pk = "researchproduct2date_hk" -%}
{%- set src_fk = ["researchproduct_hk","date_hk"] -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "source" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
