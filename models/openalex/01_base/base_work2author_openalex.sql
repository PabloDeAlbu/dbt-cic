with source as (
      select * from {{ source('openalex', 'work2author') }}
),
renamed as (
    select
        work_id,
        author_id,
        author_position,
        load_datetime
    from source
),

casted as (
    select
        work_id::varchar,
        author_id::varchar,
        author_position::varchar,
        {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime
    from renamed
),

fillna as (
    select
        COALESCE(work_id, 'NO DATA') as work_id,
        COALESCE(author_id, 'NO DATA') as author_id,
        COALESCE(author_position, 'NO DATA') as author_position,
        load_datetime
    from casted
)

select * from fillna
  