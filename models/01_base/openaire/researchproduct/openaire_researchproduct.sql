with source as (
      select * from {{ source('openaire', 'researchproduct') }}
),
renamed as (
    select
        {{ adapter.quote("dri:objIdentifier") }} as researchproduct_id,
        {{ adapter.quote("dri:dateOfCollection") }} as date_collection,
        {{ adapter.quote("dri:dateOfTransformation") }} as date_transformation,
        {{ adapter.quote("fulltext") }},
        {{ adapter.quote("dateofacceptance") }} as date_acceptance,
        {{ adapter.quote("description") }},
        {{ adapter.quote("publisher") }},
        {{ adapter.quote("isgreen") }},
        {{ adapter.quote("openaccesscolor") }},
        {{ adapter.quote("isindiamondjournal") }},
        {{ adapter.quote("publiclyfunded") }},
        {{ adapter.quote("load_datetime") }}

    from source
),

base as (
    SELECT
        researchproduct_id::varchar,
        {{ dbt_date.convert_timezone("date_collection") }} as date_collection,
        {{ dbt_date.convert_timezone("date_acceptance") }} as date_acceptance,
        COALESCE(description, 'NO DATA')::varchar as description,
        COALESCE(publisher, 'NO DATA')::varchar as publisher,
        COALESCE(isgreen::boolean, False) as isgreen,
        COALESCE(openaccesscolor, 'NO DATA')::varchar as openaccesscolor,
        COALESCE(isindiamondjournal, 'NO DATA')::varchar as isindiamondjournal,
        COALESCE(publiclyfunded, 'NO DATA')::varchar as publiclyfunded,
        -- TODO agregar métricas de impacto
        load_datetime
    FROM
        renamed
),

final as (
    select * from base
)

select * from final
