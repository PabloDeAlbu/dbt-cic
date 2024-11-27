{{ config(materialized='table') }}

with base as (
    SELECT
        rp2pid.id,
        COALESCE(rp2attrank.measure_score, 0) as attrank,
        COALESCE(rp2cc.measure_score, 0) as cc,
        COALESCE(rp2downloads.measure_score, 0) as downloads,
        COALESCE(rp2icc.measure_score, 0) as icc,
        COALESCE(rp2pr.measure_score, 0) as pr,
        COALESCE(rp2ram.measure_score, 0) as ram,
        COALESCE(rp2views.measure_score, 0) as views,
        rp2pid.load_datetime
    FROM 
        {{ ref('base_openaire_researchproduct2measure') }} rp2pid
    LEFT JOIN {{ ref('norm_openaire_researchproduct2attrank')}} rp2attrank ON rp2attrank.id = rp2pid.id
    LEFT JOIN {{ ref('norm_openaire_researchproduct2cc')}} rp2cc ON rp2cc.id = rp2pid.id
    LEFT JOIN {{ ref('norm_openaire_researchproduct2downloads')}} rp2downloads ON rp2downloads.id = rp2pid.id
    LEFT JOIN {{ ref('norm_openaire_researchproduct2icc')}} rp2icc ON rp2icc.id = rp2pid.id
    LEFT JOIN {{ ref('norm_openaire_researchproduct2pr')}} rp2pr ON rp2pr.id = rp2pid.id
    LEFT JOIN {{ ref('norm_openaire_researchproduct2ram')}} rp2ram ON rp2ram.id = rp2pid.id
    LEFT JOIN {{ ref('norm_openaire_researchproduct2views')}} rp2views ON rp2views.id = rp2pid.id
),

final as (
    select * from base
)

select * from final
