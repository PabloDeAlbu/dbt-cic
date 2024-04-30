with base as (
    SELECT item_id, d.doi
    FROM {{ source('ir', 'item') }} i
    INNER JOIN {{ source('ir', 'doi') }} d ON i.item_id = d.resource_id
    WHERE d.resource_type_id = 2
),

final as (
    select * from base
)

select * from final
