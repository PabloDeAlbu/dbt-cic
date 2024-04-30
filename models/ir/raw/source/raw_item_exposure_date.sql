with base as (
    {{ select_metadatavalue('exposure_date', 'sedici', 'date', 'exposure')}}
),

final as (
    select * from base
)

select * from final