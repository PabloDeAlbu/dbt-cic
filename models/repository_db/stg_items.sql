with repository_db_item as (
    select * from {{ source('repository_db', 'repository_db_item') }}
),

final as (
    select * from repository_db_item
)

select * from final