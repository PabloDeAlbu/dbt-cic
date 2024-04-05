with base as (
    {{ select_metadatavalue('type', 'dc', 'type')}}
),

final as (
    select * from base
)

select * from final