{{ config(materialized='table') }}

with base as (
    SELECT
        id,
        pid_text,
        load_datetime
    FROM 
        {{ ref('base_openaire_researchproduct2pid') }} rp
    WHERE pid_id = 'handle'
),

final as (
    select * from base
)

select * from final
