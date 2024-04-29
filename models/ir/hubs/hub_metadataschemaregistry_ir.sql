{{ config(materialized='incremental')    }}

{%- set source_model = "stg_metadataschemaregistry_ir" -%}
{%- set src_pk = "metadataschema_hk" -%}
{%- set src_nk = "metadata_schema_id" -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                   src_source=src_source, source_model=source_model) }}
