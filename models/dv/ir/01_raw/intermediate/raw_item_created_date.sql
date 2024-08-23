with base as (
    {{ select_metadatavalue('created_date', 'dc', 'date', 'created')}}
),

final as (
    -- TODO extraer a macro parse_date
    select
        item_id,
        created_date
    from base
    where 
        created_date != '1993-94-01' and 
        created_date != '1' and 
        created_date != '300' and 
        created_date != '800' and 
        created_date != 'b016-01-01' and 
        created_date != '20-07-24'
)

select * from final