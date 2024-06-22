{{ config(materialized='table') }}

with base as (
    SELECT
        id, 
        {# dateOfCollection,  #}
        LOWER(doi) as doi, 
        pmid, 
        pmc, 
        "arXiv" as arxiv, 
        uniprot, 
        ena, 
        pdb, 
        bestaccessright, 
        dateofacceptance, 
        publisher, 
        resulttype, 
        resourcetype, 
        isgreen, 
        openaccesscolor, 
        isindiamondjournal, 
        publiclyfunded,
        load_datetime
    FROM 
        {{ source('openaire', 'researchproduct') }} rp
),

final as (
    select * from base
)

select * from final
