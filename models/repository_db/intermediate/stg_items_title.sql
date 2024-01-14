with base as (
    {{ select_metadatavalue('title', 'dc', 'title')}}
),

final as (
    select * from base
)

select * from final