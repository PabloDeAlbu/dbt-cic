with base as (
    SELECT map."Handle" as community_handle, map."Titulo" as community_name, map."Unidad Académica" as orgunit_name
    FROM {{ ref('seed_handle_ua') }} map
),

final as (
    select * from base
)

select * from final
