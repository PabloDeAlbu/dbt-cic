{{ config(materialized = "table") }}

WITH item AS (
    SELECT 
    title,
    title_alternative,
    identifier_0,
    identifier_1,
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
    FROM {{ source('oai', 'item') }}
)

SELECT * FROM item