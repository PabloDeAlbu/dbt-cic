{{ config(materialized='incremental') }}

{%- set source_model = "stg_resourcetype_coar2worktype_openalex" -%}
{%- set src_pk = "sal_resourcetype_hk" -%}
{%- set src_fk = ["resourcetype_hk", "worktype_hk"] -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "source" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
