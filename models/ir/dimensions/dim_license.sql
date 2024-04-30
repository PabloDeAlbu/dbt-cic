with base as (
    SELECT 
    *
    FROM {{ref('hub_license_ir')}}
),

final as (
    SELECT license_hk, license_uri 
    FROM base
)

SELECT * FROM final