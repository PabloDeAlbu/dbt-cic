with source as (
      select * from {{ source('openalex', 'work2authorship') }}
),
renamed as (
    select
        

    from source
)
select * from renamed
  