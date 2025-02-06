with source as (
  select * from {{ source('dspace5', 'metadatafieldregistry') }}
),

renamed as (
  select
    {{ adapter.quote("metadata_field_id") }},
    {{ adapter.quote("metadata_schema_id") }},
    {{ adapter.quote("element") }},
    {{ adapter.quote("qualifier") }},
    {{ adapter.quote("scope_note") }},
    {{ adapter.quote("load_datetime") }}

  from source
),

casted as (
  select
    metadata_field_id::varchar,
    metadata_schema_id::varchar,
    element::varchar,
    qualifier::varchar,
    scope_note::varchar,
    {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime

  from renamed
)

select * from casted
