{{ config(materialized='table') }}

{%- set source_model = 'stg_publication_ir' -%}
{%- set src_pk = ['publication_hk', 'handle_hk', 'doi_hk'] -%}
{%- set src_fk = ['internal_identifier', 'handle', 'doi'] -%}
{%- set src_ldts = 'load_datetime' -%}
{%- set src_source = 'source' -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
