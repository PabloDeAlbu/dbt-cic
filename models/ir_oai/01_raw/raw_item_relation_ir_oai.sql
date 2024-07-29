{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        handle,
        relation,
        load_datetime
    FROM {{ source('ir_oai', 'item_relation') }}
),

final AS (
    SELECT
        *
    FROM base
)

SELECT * FROM final