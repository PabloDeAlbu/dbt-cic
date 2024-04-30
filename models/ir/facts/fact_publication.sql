with base as (
    SELECT 
        * 
    FROM {{ref('sal_publication_ir')}} publication
    INNER JOIN {{ref('link_publication_type_ir')}} link_publication_type 
        ON link_publication_type.publication_hk = publication.publication_hk
    INNER JOIN {{ref('hub_type_ir')}} type
        ON type.type_hk = link_publication_type.type_hk
),

final as (
    SELECT
        doi,
        handle,
        subtype
    FROM base
)

select * from final