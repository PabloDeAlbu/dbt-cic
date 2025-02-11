with source as (
  select * from {{ source('openaire_graph_researchproduct', 'researchproduct2url') }}
),

filtered as (
  select 
    id,
    url,
    load_datetime
  from source
  where url is not null
),

renamed as (
  select 
    id as researchproduct_id,
    url,
    load_datetime
  from filtered
),

casted as (
  select 
  researchproduct_id::varchar,
  url::varchar,
  {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime
  from renamed
)

select * from casted