with source as (
        select * from {{ source('openaire_researchproduct_collectedfrom_datasource', 'researchproduct') }}
  ),
  renamed as (
      select
        COALESCE({{ adapter.quote("openAccessColor") }}::varchar, 'NO DATA') as open_access_color,
        COALESCE({{ adapter.quote("publiclyFunded") }}::varchar, 'NO DATA') as publicly_funded,
        COALESCE({{ adapter.quote("type") }}::varchar, 'NO DATA') as type,
        COALESCE({{ adapter.quote("mainTitle") }}::varchar, 'NO DATA') as main_title,
        {{ dbt_date.convert_timezone(adapter.quote("publicationDate")) }} as publication_date,
        {{ adapter.quote("id") }} as researchproduct_id,
        COALESCE({{ adapter.quote("isGreen") }}::boolean, FALSE) as is_green,
        COALESCE({{ adapter.quote("isInDiamondJournal") }}::boolean, FALSE) as is_in_diamond_journal,
        COALESCE({{ adapter.quote("language_code") }}::varchar, 'NO DATA') as language_code,
        COALESCE({{ adapter.quote("language_label") }}::varchar, 'NO DATA') as language_label,
        COALESCE({{ adapter.quote("bestAccessRight_label") }}::varchar, 'NO DATA') as best_access_right,
        COALESCE({{ adapter.quote("citationImpact.citationClass") }}::varchar, 'NO DATA') as citation_impact_class,
        COALESCE({{ adapter.quote("citationImpact.citationCount") }}::int , 0) as citation_impact_count,
        COALESCE({{ adapter.quote("citationImpact.impulse") }}::float, 0) as citation_impact_impulse,
        COALESCE({{ adapter.quote("citationImpact.impulseClass") }}::varchar, 'NO DATA') as citation_impact_impulse_class,
        COALESCE({{ adapter.quote("citationImpact.influence") }}::float, 0) as citation_impact_influence,
        COALESCE({{ adapter.quote("citationImpact.influenceClass") }}::varchar, 'NO DATA') as citation_impact_influence_class,
        COALESCE({{ adapter.quote("citationImpact.popularity") }}::float, 0) as citation_impact_popularity,
        COALESCE({{ adapter.quote("citationImpact.popularityClass") }}::varchar, 'NO DATA') as citation_impact_popularity_class,
        COALESCE({{ adapter.quote("load_datetime") }}::varchar, 'NO DATA') as load_datetime
      from source
  )
  select * from renamed
    