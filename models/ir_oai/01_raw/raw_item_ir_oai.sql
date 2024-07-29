{{ config(materialized = "table") }}

WITH base AS (
    SELECT 
        title,
        title_alternative,
        handle,
        date_issued,
        date_exposure,
        description,
        type_openaire,
        type_snrd,
        version,
        access_right,
        access_level,
        license_condition,
        load_datetime
    FROM {{ source('ir_oai', 'item') }}
),

final AS (
    SELECT 
        *
    FROM base
)

SELECT * FROM final