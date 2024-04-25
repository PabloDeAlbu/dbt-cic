{{ config(materialized='incremental')         }}

{%- set source_model = "stg_authorship_openalex" -%}
{%- set src_pk = "authorship_hk" -%}
{%- set src_fk = ["author_hk", "work_hk"] -%}
{%- set src_ldts = "_airbyte_extracted_at" -%}
{%- set src_source = "source" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
