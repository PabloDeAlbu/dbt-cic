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
        -- TODO Esto tendría que ser una dim. Contemplar casos de fechas vacias.
        date.date_text as published_online,
        measure.downloads,
        measure.impulse,
        measure.influence_alt,
        measure.influence,
        measure.popularity_alt,
        measure.popularity,
        measure.views,
        rp.load_datetime
    FROM 
        {{ ref('base_openaire_researchproduct') }} rp
    LEFT JOIN {{ ref('norm_openaire_researchproduct2publishedonline')}} date ON date.researchproduct_id = rp.researchproduct_id
    INNER JOIN {{ ref('norm_openaire_researchproduct2measure')}} measure ON measure.researchproduct_id = rp.researchproduct_id
),

final as (
    select * from base
)

select * from final
