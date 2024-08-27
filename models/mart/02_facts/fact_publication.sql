WITH base as (
    SELECT
        {{ dbt_utils.star(
                from=ref('sal_work_openalex'), 
                except=['work_hk']
        )}},
        {{ dbt_utils.star(
            from=ref('sat_work_openalex'), 
            except=['work_hk','hashdiff','load_datetime', 'source']
        )}}
    FROM {{ref('sal_work_openalex')}} sal_work
    INNER JOIN {{ref('sat_work_openalex')}} sat_work ON sal_work.work_hk = sat_work.work_hk
)

SELECT * FROM base
