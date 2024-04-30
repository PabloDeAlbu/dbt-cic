{{ config(materialized = "table") }}

WITH base AS (
    SELECT
        *
    FROM {{ ref('raw_item_subtype') }}
),

final AS (
    SELECT * from base
)

SELECT * FROM final