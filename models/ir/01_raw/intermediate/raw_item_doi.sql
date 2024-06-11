WITH base AS (
    {{ select_metadatavalue('doi', 'sedici', 'identifier', 'other', True)}}
),

start_with_doi AS (
    SELECT * 
    FROM base
    WHERE doi LIKE 'doi:%'
),

norm_start_with_doi AS (
    SELECT item_id, replace(doi, 'doi:', 'https://doi.org/') AS doi, authority, 'not_url_to_url' 
    FROM start_with_doi
),

is_url AS (
    SELECT item_id, doi, authority, 'is_url'
    FROM base
    WHERE doi similar TO 'https?://\S+' AND doi LIKE '%doi%'
),

final AS (
    SELECT * 
    FROM is_url 
    UNION 
    SELECT * 
    FROM norm_start_with_doi
)

SELECT * FROM final
