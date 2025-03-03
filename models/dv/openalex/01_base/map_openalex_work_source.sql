with source as (
      select * from {{ source('openalex', 'map_work_location') }}
),
renamed as (
    select
        {{ adapter.quote("id") }} as work_id,
        {{ adapter.quote("source_id") }},
        {{ adapter.quote("source_display_name") }},
        {{ adapter.quote("source_is_core") }},
        {{ adapter.quote("source_type") }},
        {{ adapter.quote("source_host_organization") }},
        {{ adapter.quote("source_host_organization_name") }},
        {{ adapter.quote("is_accepted") }},
        {{ adapter.quote("is_oa") }},
        {{ adapter.quote("is_published") }},
        {{ adapter.quote("landing_page_url") }},
        {{ adapter.quote("license") }},
        {{ adapter.quote("license_id") }},
        {{ adapter.quote("pdf_url") }},
        {{ adapter.quote("version") }},
        {{ adapter.quote("source_is_in_doaj") }},
        {{ adapter.quote("source_is_oa") }},
        {{ adapter.quote("source_issn_l") }},
        {{ adapter.quote("load_datetime") }}
    from source
),

casted as (
    select
        work_id::varchar,
        source_id::varchar,
        source_display_name::varchar,
        source_type::varchar,
        source_host_organization::varchar,
        source_host_organization_name::varchar,
        source_is_core::varchar,
        source_issn_l::varchar,
        landing_page_url::varchar,
        license::varchar,
        license_id::varchar,
        pdf_url::varchar,
        version::varchar,
        is_accepted::boolean,
        is_oa::boolean,
        is_published::boolean,
        source_is_in_doaj::boolean,
        source_is_oa::boolean,
        {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime
    from renamed
),

fillna as (
    select
        COALESCE(work_id, 'NO DATA') as work_id,
        COALESCE(source_id, 'NO DATA') as source_id,
        COALESCE(source_display_name, 'NO DATA') as source_display_name,
        COALESCE(source_type, 'NO DATA') as source_type,
        COALESCE(source_host_organization, 'NO DATA') as source_host_organization,
        COALESCE(source_host_organization_name, 'NO DATA') as source_host_organization_name,
        COALESCE(source_is_core, 'NO DATA') as source_is_core,
        COALESCE(source_issn_l, 'NO DATA') as source_issn_l,
        COALESCE(landing_page_url, 'NO DATA') as landing_page_url,
        COALESCE(license, 'NO DATA') as license,
        COALESCE(license_id, 'NO DATA') as license_id,
        COALESCE(pdf_url, 'NO DATA') as pdf_url,
        COALESCE(version, 'NO DATA') as version,
        COALESCE(is_accepted, False) as is_accepted,
        COALESCE(is_oa, False) as is_oa,
        COALESCE(is_published, False) as is_published,
        COALESCE(source_is_in_doaj, False) as source_is_in_doaj,
        COALESCE(source_is_oa, False) as source_is_oa,
        load_datetime
    from casted
)

select * from fillna
  