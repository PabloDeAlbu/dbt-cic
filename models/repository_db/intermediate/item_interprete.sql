with base as (
    {{ select_metadatavalue('interprete_name','sedici','creator','interprete', True)}}
),

final as (
    select * from base
)

select * from final
