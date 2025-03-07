with source as (
  select 
    i.item_id,
    i2title.title,
    i2title.title_lang,
    i2type.type,
    i2handle.handle,
    COALESCE(i2doi.doi, 'NO DATA') as doi,
    i.last_modified,
    i.load_datetime
  from {{ ref('base_dspace5_item') }} i
  inner join {{ ref('base_dspace5_item2title') }} i2title ON i2title.item_id = i.item_id
  inner join {{ ref('base_dspace5_item2type') }} i2type ON i2type.item_id = i.item_id
  inner join {{ ref('base_dspace5_item2handle') }} i2handle ON i2handle.item_id = i.item_id
  left join {{ ref('base_dspace5_item2doi') }} i2doi ON i2doi.item_id = i.item_id
)

select * from source
