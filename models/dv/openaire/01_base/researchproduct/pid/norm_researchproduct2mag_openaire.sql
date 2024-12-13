{{ config(materialized='table') }}

with base as (
    SELECT
        researchproduct_id,
        pid_text,
        load_datetime
    FROM 
        {{ ref('base_researchproduct2pid_openaire') }} rp
    WHERE pid_id = 'mag_id'
),

final as (
    select * from base
)

select * from final
