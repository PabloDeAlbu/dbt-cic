with 

base as (
    SELECT 
    type_hk,
    UPPER(subtype) as subtype,
    load_datetime,
    source
    FROM {{ref('hub_type_ir')}}
    ORDER BY subtype
),

seed as (
    SELECT 
    type,
    subtype,
    label_es
    FROM {{ref('map_sedici-types2coar-types')}}
    ORDER BY subtype
),

final as (
    SELECT * 
    FROM base
    INNER JOIN seed ON seed.subtype = base.subtype
)

SELECT * FROM final