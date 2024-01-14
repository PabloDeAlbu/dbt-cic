with base as (
    {{ select_metadatavalue('language', 'dc', 'language')}}
),

final as (
    select * from base
)

select * from final