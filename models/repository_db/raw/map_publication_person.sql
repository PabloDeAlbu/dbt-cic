with items_person as (
    SELECT *, 'codirector' as role FROM {{ ref('raw_item_codirector_ir_db') }}
    UNION 
    SELECT *, 'colaborator' as role FROM {{ ref('raw_item_colaborator_ir_db') }}
    UNION 
    SELECT *, 'compiler' as role FROM {{ ref('raw_item_compiler_ir_db') }}
    UNION 
    SELECT *, 'creator' as role FROM {{ ref('raw_item_creator_ir_db') }}
    UNION 
    SELECT *, 'director' as role FROM {{ ref('raw_item_director_ir_db') }}
    UNION 
    SELECT *, 'editor' as role FROM {{ ref('raw_item_editor_ir_db') }}
    UNION 
    SELECT *, 'inscriber' as role FROM {{ ref('raw_item_inscriber_ir_db') }}
    UNION 
    SELECT *, 'interprete' as role FROM {{ ref('raw_item_interprete_ir_db') }}
    UNION 
    SELECT *, 'juror' as role FROM {{ ref('raw_item_juror_ir_db') }}
    UNION 
    SELECT *, 'translator' as role FROM {{ ref('raw_item_translator_ir_db') }}
),

final as (
    SELECT 
        ip.item_id as publication_internal_identifier,
        p.handle as publication_handle,
        codirector_name as person_name,
        role,
        authority as person_internal_identifier
    FROM items_person ip
    INNER JOIN {{ ref('raw_item_ir_db') }} p ON p.item_id = ip.item_id
    WHERE p.handle is not null
)

select * from final