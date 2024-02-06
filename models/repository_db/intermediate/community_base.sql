with base as (
	SELECT c2c.parent_comm_id, c.community_id, mv.text_value
	FROM source.community c
	LEFT JOIN source.community2community c2c ON c.community_id = c2c.child_comm_id
	INNER JOIN source.metadatavalue mv ON (mv.resource_id = c.community_id AND mv.resource_type_id = 4 AND mv.metadata_field_id = 64)
	WHERE c2c.parent_comm_id IS NULL
)

select * from base