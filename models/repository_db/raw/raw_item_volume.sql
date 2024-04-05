with base as (
    {{ select_metadatavalue('volume', 'sedici', 'relation', 'journalVolumeAndIssue')}}
),

final as (
    select * from base
)

select * from final