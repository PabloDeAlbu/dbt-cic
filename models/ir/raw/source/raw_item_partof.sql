with base as (
    {{ select_metadatavalue('partof', 'sedici', 'relation', 'bookTitle')}}
),

final as (
    select * from base
)

select * from final