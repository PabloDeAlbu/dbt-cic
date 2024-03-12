with base as (
    {{ select_metadatavalue('orgunit_name', 'thesis', 'degree', 'grantor', True)}}
),

final as (
    select * from base
)

select * from final
