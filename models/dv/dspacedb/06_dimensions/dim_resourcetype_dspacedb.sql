WITH base AS (
    SELECT * 
    FROM {{ref('sal_item_dspacedb')}}
)

SELECT * FROM base