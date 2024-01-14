{% macro select_metadatavalue(column_name, short_id, element, qualifier = NULL) %}
    SELECT 
        mv.resource_id AS item_id,
        mv.text_value AS {{ column_name }}
    FROM {{ source('repository_db', 'repository_db_metadatavalue') }} mv
    INNER JOIN {{ source('repository_db', 'repository_db_metadatafieldregistry') }} mfr ON mfr.metadata_field_id = mv.metadata_field_id
    INNER JOIN {{ source('repository_db', 'repository_db_metadataschemaregistry') }} msr ON msr.metadata_schema_id = mfr.metadata_schema_id
    WHERE 
        mv.resource_type_id = 2 
        and msr.short_id = '{{ short_id }}'
        and mfr.element = '{{ element }}' 
        {% if qualifier != NULL %}
            and mfr.qualifier = '{{ qualifier }}'
        {% else %}
            and mfr.qualifier is NULL
        {% endif %}
{% endmacro %}
