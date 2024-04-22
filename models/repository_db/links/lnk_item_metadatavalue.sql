{{ config(materialized='table')         }}

{%- set source_model = "stg_item_ir"        -%}
{%- set src_pk = "item_metadatavalue_hk"         -%}
{%- set src_fk = ["item_hk", "metadata_value_hk"] -%}
{%- set src_ldts = "LOAD_DATETIME"           -%}
{%- set src_source = "RECORD_SOURCE"         -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
