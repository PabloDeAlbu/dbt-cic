with source as (
        select * from {{ source('openaire', 'researchproduct') }}
  ),
  renamed as (
      select
        {{ adapter.quote("id") }}::varchar as researchproduct_id,
        COALESCE({{ adapter.quote("openAccessColor") }}::varchar, 'NO DATA') as open_access_color,
        COALESCE({{ adapter.quote("publiclyFunded") }}::varchar, 'NO DATA') as publicly_funded,
        COALESCE({{ adapter.quote("type") }}::varchar, 'NO DATA') as type,
        COALESCE({{ adapter.quote("mainTitle") }}::varchar, 'NO DATA') as main_title,
        {{ dbt_date.convert_timezone(adapter.quote("publicationDate")) }} as publication_date,
        COALESCE({{ adapter.quote("publisher") }}::varchar, 'NO DATA') as publisher,
        {{ dbt_date.convert_timezone(adapter.quote("embargoEndDate")) }} as embargo_end_date,
        COALESCE({{ adapter.quote("isGreen") }}::boolean, FALSE) as is_green,
        COALESCE({{ adapter.quote("isInDiamondJournal") }}::boolean, FALSE) as is_in_diamond_journal,
        COALESCE({{ adapter.quote("language_code") }}::varchar, 'NO DATA') as language_code,
        COALESCE({{ adapter.quote("language_label") }}::varchar, 'NO DATA') as language_label,
        COALESCE({{ adapter.quote("bestAccessRight_label") }}::varchar, 'NO DATA') as best_access_right,
        COALESCE({{ adapter.quote("bestAccessRight_scheme") }}::varchar, 'NO DATA') as best_access_right_uri,
        COALESCE({{ adapter.quote("citationImpact.citationClass") }}::varchar, 'NO DATA') as citation_class,
        COALESCE({{ adapter.quote("citationImpact.citationCount") }}::int , 0) as citation_count,        
        COALESCE({{ adapter.quote("citationImpact.impulse") }}::float, 0) as impulse,
        COALESCE({{ adapter.quote("citationImpact.impulseClass") }}::varchar, 'NO DATA') as impulse_class,
        COALESCE({{ adapter.quote("citationImpact.influence") }}::float, 0) as influence,
        COALESCE({{ adapter.quote("citationImpact.influenceClass") }}::varchar, 'NO DATA') as influence_class,
        COALESCE({{ adapter.quote("citationImpact.popularity") }}::float, 0) as popularity,
        COALESCE({{ adapter.quote("citationImpact.popularityClass") }}::varchar, 'NO DATA') as popularity_class,
        COALESCE({{ adapter.quote("usageCounts.downloads") }}::int , 0) as downloads,
        COALESCE({{ adapter.quote("usageCounts.views") }}::int , 0) as views,
        {{ dbt_date.convert_timezone("load_datetime") }} as load_datetime
      from source
  )
  select * from renamed
