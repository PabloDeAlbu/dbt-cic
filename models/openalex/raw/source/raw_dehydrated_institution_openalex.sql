{{ config(materialized='table') }}

with base as (
    SELECT
        DISTINCT institutions->0->>'id' as id,
        institutions->0->>'ror' as ror,
        institutions->0->>'type' as type,
        institutions->0->>'lineage' as lineage,
        _airbyte_extracted_at::date
    FROM 
         {{ ref('raw_authorship_openalex') }}
    WHERE institutions->0->>'id' is not null
),

final as (
    select * from base
)

select * from final
