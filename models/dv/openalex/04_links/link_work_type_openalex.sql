{{ config(materialized='incremental') }}

{%- set source_model = "stg_work_openalex" -%}
{%- set src_pk = "work_type_hk" -%}
{%- set src_fk = ["work_hk", "type_hk"] -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "source" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
