{{ config(materialized='table') }}

with base as (
    SELECT
        researchproduct_id,
        pid_text,
        load_datetime
    FROM 
        {{ ref('base_openaire_researchproduct2pid') }} rp
    WHERE pid_id = 'doi'
),

final as (
    select * from base
)

select * from final
