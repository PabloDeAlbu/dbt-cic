with base as (
    {{ select_metadatavalue('grantor_name', 'thesis', 'degree', 'grantor', True)}}
),

final as (
    select * from base
)

select * from final
