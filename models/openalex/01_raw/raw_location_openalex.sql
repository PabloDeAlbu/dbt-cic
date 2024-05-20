{{ config(materialized='table') }}

WITH base AS (
    SELECT
        id as work_id,
        jsonb_array_elements(locations)->>'is_accepted' as is_accepted,
        jsonb_array_elements(locations)->>'is_oa' as is_oa,
        jsonb_array_elements(locations)->'source'->>'id' as source_id,
        jsonb_array_elements(locations)->'source'->>'display_name' as source_display_name,
        jsonb_array_elements(locations)->'source'->>'issn_l' as source_issn_l,
        jsonb_array_elements(locations)->'source'->>'issn' as source_issn,
        jsonb_array_elements(locations)->'source'->>'host_organization' as source_host_organization,
        jsonb_array_elements(locations)->'source'->>'type' as source_type

    FROM 
         {{ source('openalex', 'openalex_works_unlp') }} works
),

final as (
    SELECT * FROM base
)

SELECT * FROM final
