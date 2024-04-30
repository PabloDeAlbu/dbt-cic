with base as (
    {{ select_metadatavalue('license_uri', 'sedici', 'rights', 'uri')}}
),

final as (
    select * from base
)

select * from final