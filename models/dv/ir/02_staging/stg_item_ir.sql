{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: "raw_item_ir"
derived_columns:
  source: "!IR_DB"
  load_datetime: _airbyte_extracted_at
  effective_from: last_modified
  start_date: last_modified
  end_date: to_date('9999-12-31', 'YYYY-MM-DD')
hashed_columns:
  item_hk: item_id
  submitter_hk: submitter_id
  item_submitter_hk:
    - item_id
    - submitter_id
  owningcollection_hk: owning_collection
  item_owningcollection_hk:
    - item_id
    - owning_collection
  type_hk: type
  item_type_hk:
    - item_id
    - type
  subtype_hk: subtype
  item_subtype_hk:
    - item_id
    - subtype
  handle_hk: handle
  item_handle_hk:
    - item_id
    - handle
  doi_hk: doi
  item_doi_hk:
    - item_id
    - doi
  item_hashdiff:
    is_hashdiff: true
    columns:
      - title
      - subtitle
      - available_date
      - created_date
      - exposure_date
      - publication_date
      - partof
      - volume
      - last_modified
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
