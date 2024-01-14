with base as (
    {{ select_metadatavalue('available_date', 'dc', 'date', 'available')}}
),

final as (
    select * from base
)

select * from final