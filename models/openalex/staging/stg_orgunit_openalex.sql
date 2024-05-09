{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_orgunit_openalex"
derived_columns:
  source: "!OPENALEX"
  load_datetime: _airbyte_extracted_at
  {# TODO se debería usar algo como https://docs.openalex.org/api-entities/works/work-object#created_date en effective_from  #}
  {# effective_from: _airbyte_extracted_at
  start_date: _airbyte_extracted_at
  end_date: to_date('9999-12-31', 'YYYY-MM-DD') #}
hashed_columns:
  orgunit_hk: internal_identifier
  rorid_hk: rorid
  institution_type_hk: institution_type
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
{% set source_model = metadata_dict['source_model'] %}
{% set derived_columns = metadata_dict['derived_columns'] %}
{% set hashed_columns = metadata_dict['hashed_columns'] %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=source_model,
                     derived_columns=derived_columns,
                     null_columns=none,
                     hashed_columns=hashed_columns,
                     ranked_columns=none) }}

