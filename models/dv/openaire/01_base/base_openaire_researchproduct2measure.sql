{{ config(materialized='table') }}

with source as (
      select * from {{ source('openaire', 'researchproduct2measure') }}
),
renamed as (
    select
        {{ adapter.quote("dri:objIdentifier") }} as id,
        {{ adapter.quote("@id") }} as measure_id,
        {{ adapter.quote("@score") }}::float as measure_score,
        {{ adapter.quote("@class") }} as measure_class,
        {{ adapter.quote("@datasource") }} measure_datasource,
        {{ adapter.quote("load_datetime") }}
    from source
)
select * from renamed
  