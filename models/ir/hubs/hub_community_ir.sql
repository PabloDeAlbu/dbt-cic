{{ config(materialized='incremental')    }}

{%- set source_model = "stg_community_ir" -%}
{%- set src_pk = "community_hk" -%}
{%- set src_nk = "community_id" -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                   src_source=src_source, source_model=source_model) }}
