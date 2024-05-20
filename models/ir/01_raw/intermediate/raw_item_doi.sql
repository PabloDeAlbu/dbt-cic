WITH base AS (
    {{ select_metadatavalue('doi', 'sedici', 'identifier', 'other', True)}}
),

not_url as (
    SELECT * FROM base
    where doi like 'doi:%'
),

not_url_to_url as (
    SELECT item_id, replace(not_url.doi, 'doi:', 'https://doi.org') as doi, authority 
    FROM not_url
),

is_url as (
    SELECT * FROM base
    where doi similar to 'https?://\S+' and doi like '%doi%'
),

final as (
    SELECT * 
    FROM is_url 
    UNION 
    SELECT * 
    FROM not_url_to_url
)

SELECT * FROM final
