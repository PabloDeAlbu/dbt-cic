with base as (
    SELECT 
    *
    FROM {{ref('hub_type_ir')}}
    ORDER BY subtype
),

final as (
    SELECT * FROM base
)

SELECT * FROM final