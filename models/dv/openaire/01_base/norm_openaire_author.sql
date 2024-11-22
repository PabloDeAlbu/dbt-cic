{{ config(materialized='table') }}

with base as (
    SELECT
        *
    FROM 
        {{ ref('base_openaire_researchproduct') }} rp
),

final as (
    select * from base
)

select * from final
