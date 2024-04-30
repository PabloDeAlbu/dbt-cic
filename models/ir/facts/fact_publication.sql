with base as (
    SELECT 
        publication.publication_hk,
        publication.doi,
        publication.handle,
        type.subtype,
        language.language,
        license.license_uri,
        sat.title,
        sat.subtitle,
        sat.available_date,
        sat.created_date,
        sat.exposure_date,
        sat.publication_date,
        sat.partof,
        sat.volume,
        sat.last_modified
    FROM {{ref('sal_publication_ir')}} publication
    INNER JOIN {{ref('link_publication_type_ir')}} link_publication_type 
        ON link_publication_type.publication_hk = publication.publication_hk
    INNER JOIN {{ref('hub_type_ir')}} type
        ON type.type_hk = link_publication_type.type_hk
    INNER JOIN {{ref('link_publication_language_ir')}} link_publication_language
        ON link_publication_language.publication_hk = publication.publication_hk
    INNER JOIN {{ref('hub_language_ir')}} language
        ON language.language_hk = link_publication_language.language_hk
    INNER JOIN {{ref('link_publication_license_ir')}} link_publication_license
        ON link_publication_license.publication_hk = publication.publication_hk
    INNER JOIN {{ref('hub_license_ir')}} license
        ON license.license_hk = link_publication_license.license_hk
    INNER JOIN {{ref('sat_publication_ir')}} sat
        ON sat.publication_hk = publication.publication_hk
),

final as (
    SELECT
        *
    FROM base
)

select * from final