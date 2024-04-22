{# {{ config(materialized = "table") }} #}
WITH base AS (
    SELECT
        internal_identifier,
        type,
        subtype,
        language,
        {{ str_to_date('available_date') }} as available_date,
        {{ str_to_date('created_date') }} as created_date,
        {{ str_to_date('exposure_date') }} as exposure_date,
        {{ str_to_date('publication_date') }} as publication_date,
        title,
        subtitle,
        handle,
        doi,
        license_uri,
        partof,
        volume,
        last_modified
    FROM {{ ref('build_publication_ir') }}
),

final AS (
    SELECT *
    FROM base
)

select * from final