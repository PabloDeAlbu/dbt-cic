{{ config(materialized='table') }}

with base as (
    SELECT 
        author->>'id' as id,
        author->>'orcid' as orcid,
        author->>'display_name' as display_name,
        _airbyte_extracted_at
    FROM 
         {{ ref('raw_authorship_openalex') }}
),

final as (
    select * from base
)

select * from final
