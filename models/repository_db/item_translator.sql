with base as (
    {{ select_metadatavalue('translator_name','sedici','contributor','translator', True)}}
),

final as (
    select * from base
)

select * from final
