WITH base AS (
    SELECT 
    uri,
    label,
    parent_label_1,
    parent_label_2,
    parent_label_3,
    label_es 
    FROM 
    {{ ref('resource_type_coar')}}
)

SELECT * FROM base