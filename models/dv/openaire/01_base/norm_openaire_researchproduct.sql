{{ config(materialized='table') }}

with base as (
    SELECT
        id,
        dateofcollection,
        dateofacceptance,
        description,
        publisher,
        isgreen,
        openaccesscolor,
        isindiamondjournal,
        publiclyfunded,
        load_datetime
-- TODO multivaluado. procesar en landing        fulltext, 
    FROM 
        {{ ref('base_openaire_researchproduct') }} rp
),

final as (
    select * from base
)

select * from final
