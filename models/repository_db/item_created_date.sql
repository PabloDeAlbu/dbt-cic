with base as (
    {{ select_metadatavalue('created_date', 'dc', 'date', 'created')}}
),

final as (
    select * from base
)

select * from final