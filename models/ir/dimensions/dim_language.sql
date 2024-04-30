with base as (
    SELECT 
    *
    FROM {{ref('hub_language_ir')}}
),

final as (
    SELECT language_hk, language
    FROM base
)

SELECT * FROM final