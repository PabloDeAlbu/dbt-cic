{{ config(materialized='incremental') }}

{%- set source_model = "stg_publication_person_openalex" -%}
{%- set src_pk = "publication_person_hk" -%}
{%- set src_fk = ["publication_hk", "person_hk"] -%}
{%- set src_ldts = "_airbyte_extracted_at" -%}
{%- set src_source = "source" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}
