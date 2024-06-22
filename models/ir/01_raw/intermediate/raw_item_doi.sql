WITH base AS (
    {{ select_metadatavalue('doi', 'sedici', 'identifier', 'other', True)}}
),

include_doi AS (
    SELECT * 
    FROM base
    WHERE doi LIKE '%doi%'
),

final AS (
    SELECT 
        item_id,
        lower('10.' || split_part(doi, '10.',2)) as doi,
        authority
    FROM include_doi
)

SELECT * FROM final
