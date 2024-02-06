with base as (
    SELECT item_id, d.doi
    FROM {{ source('repository_db', 'item') }} i
    INNER JOIN {{ source('repository_db', 'doi') }} d ON i.item_id = d.resource_id
    WHERE d.resource_type_id = 2
),

final as (
    select * from base
)

select * from final
