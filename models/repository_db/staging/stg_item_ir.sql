{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_item_ir"
derived_columns:
  source: "!REPOSITORY_DB"
  load_datetime: now()
  effective_from: now()
  start_date: now()
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  item_hk: item_id
  submitter_hk: submitter_id
  owning_collection_hk: owning_collection
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
