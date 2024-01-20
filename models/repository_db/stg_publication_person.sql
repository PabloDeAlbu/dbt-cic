with items_person as (
    SELECT *, 'codirector' as role FROM {{ ref('stg_items_codirector') }}
    UNION 
    SELECT *, 'colaborator' as role FROM {{ ref('stg_items_colaborator') }}
    UNION 
    SELECT *, 'compiler' as role FROM {{ ref('stg_items_compiler') }}
    UNION 
    SELECT *, 'creator' as role FROM {{ ref('stg_items_creator') }}
    UNION 
    SELECT *, 'director' as role FROM {{ ref('stg_items_director') }}
    UNION 
    SELECT *, 'editor' as role FROM {{ ref('stg_items_editor') }}
    UNION 
    SELECT *, 'inscriber' as role FROM {{ ref('stg_items_inscriber') }}
    UNION 
    SELECT *, 'interprete' as role FROM {{ ref('stg_items_interprete') }}
    UNION 
    SELECT *, 'juror' as role FROM {{ ref('stg_items_juror') }}
    UNION 
    SELECT *, 'translator' as role FROM {{ ref('stg_items_translator') }}
),

final as (
    SELECT 
        ip.item_id as publication_internal_identifier,
        codirector_name as person_name,
        authority as person_internal_identifier,
        role
    FROM items_person ip
    INNER JOIN {{ ref('stg_publication') }} p ON p.item_id = ip.item_id
)

select * from final