{# {{ config(materialized='incremental')         }} #}

{%- set source_model = 'stg_item_ir_db' -%}
{%- set src_pk = 'item_id_hk' -%}
{%- set src_fk = ['item_id', 'handle'] -%}
{%- set src_ldts = 'load_datetime' -%}
{%- set src_source = 'source' -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
