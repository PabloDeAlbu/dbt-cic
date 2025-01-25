with source as (
      select * from {{ source('openalex', 'work2location') }}
),
renamed as (
    select
        {{ adapter.quote("work_id") }},
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
)
select * from renamed
  