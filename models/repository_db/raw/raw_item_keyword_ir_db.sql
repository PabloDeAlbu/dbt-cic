with base as (
    {{ select_metadatavalue('keyword', 'dc', 'subject', authority = True)}}
),

final as (
    select * from base
)

select * from final
