with base as (
    {{ select_metadatavalue('publication_date', 'dc', 'date', 'issued')}}
),

final as (
    select * from base
)

select * from final