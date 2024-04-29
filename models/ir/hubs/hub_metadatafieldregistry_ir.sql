{{ config(materialized='incremental')    }}

{%- set source_model = "stg_metadatafieldregistry_ir" -%}
{%- set src_pk = "metadatafield_hk" -%}
{%- set src_nk = "metadata_field_id" -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                   src_source=src_source, source_model=source_model) }}
