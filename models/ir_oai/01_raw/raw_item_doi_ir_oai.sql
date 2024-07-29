{{ config(materialized = "table") }}

WITH base AS (
    SELECT
        handle,
        lower('10.' || split_part(relation, '10.',2)) as doi,
        load_datetime
    FROM {{ ref('raw_item_relation_ir_oai') }}
    WHERE relation ilike '%doi%'
),

final AS (
    SELECT
        *
    FROM base
)

SELECT * FROM final