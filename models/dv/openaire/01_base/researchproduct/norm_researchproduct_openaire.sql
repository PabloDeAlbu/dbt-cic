{{ config(materialized='table') }}

with base as (
    SELECT
        rp.researchproduct_id,
        {{ dbt_date.convert_timezone("date_collection") }} as date_collection,
        {{ dbt_date.convert_timezone("date_acceptance") }} as date_acceptance,
        rp.description,
        rp.publisher,
        rp.isgreen,
        COALESCE(rp.openaccesscolor, 'NO DATA') as openaccesscolor,
        COALESCE(rp.isindiamondjournal::varchar, 'NO DATA') as isindiamondjournal,
        COALESCE(rp.publiclyfunded::varchar, 'NO DATA') as publiclyfunded,
        rp.load_datetime
    FROM
        {{ ref('base_researchproduct_openaire') }} rp
),

final as (
    select * from base
)

select * from final
