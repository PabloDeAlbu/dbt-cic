with items_person as (
    SELECT *, 'codirector' as role FROM {{ ref('item_codirector') }}
    UNION 
    SELECT *, 'colaborator' as role FROM {{ ref('item_colaborator') }}
    UNION 
    SELECT *, 'compiler' as role FROM {{ ref('item_compiler') }}
    UNION 
    SELECT *, 'creator' as role FROM {{ ref('item_creator') }}
    UNION 
    SELECT *, 'director' as role FROM {{ ref('item_director') }}
    UNION 
    SELECT *, 'editor' as role FROM {{ ref('item_editor') }}
    UNION 
    SELECT *, 'inscriber' as role FROM {{ ref('item_inscriber') }}
    UNION 
    SELECT *, 'interprete' as role FROM {{ ref('item_interprete') }}
    UNION 
    SELECT *, 'juror' as role FROM {{ ref('item_juror') }}
    UNION 
    SELECT *, 'translator' as role FROM {{ ref('item_translator') }}
),

final as (
    SELECT 
        ip.item_id as publication_internal_identifier,
        codirector_name as person_name,
        authority as person_internal_identifier,
        role
    FROM items_person ip
    INNER JOIN {{ ref('fact_publication') }} p ON p.item_id = ip.item_id
)

select * from final