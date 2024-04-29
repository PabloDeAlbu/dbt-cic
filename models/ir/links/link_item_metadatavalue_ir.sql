{{ config(materialized='incremental')         }}

{%- set source_model = "map_item_metadatavalue_ir" -%}
{%- set src_pk = "metadatavalue_item_hk" -%}
{%- set src_fk = ["metadatavalue_hk", "item_hk"] -%}
{%- set src_ldts = "load_datetime" -%}
{%- set src_source = "source" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
