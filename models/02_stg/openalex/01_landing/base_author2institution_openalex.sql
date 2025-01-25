with source as (
      select * from {{ source('openalex', 'author2institution') }}
),
renamed as (
    select
        

    from source
)
select * from renamed
  