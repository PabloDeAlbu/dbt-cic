{# {{ config(materialized='incremental') }} #}

{%- set yaml_metadata -%}
source_model: 'stg_item_ir_db'
src_pk: item_id_hk
src_nk: doi
src_ldts: load_datetime
src_source: source
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}
with base as (
    {{ automate_dv.hub(src_pk=metadata_dict["src_pk"],
                    src_nk=metadata_dict["src_nk"], 
                    src_ldts=metadata_dict["src_ldts"],
                    src_source=metadata_dict["src_source"],
                    source_model=metadata_dict["source_model"]) }}
),

final as (
    select * 
    from base
    where doi is not null
)

select * from final
