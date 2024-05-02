{# TODO renombar modelo a algo más expresivo
 ej: select_availabledate_from_dc_date_available #}
with base as (
    {{ select_metadatavalue('available_date', 'dc', 'date', 'available')}}
),

final as (
    select * from base
)

select * from final