with collection_stages as (
    select 
        *
    from 
        {{source('smartcollect','collection_stages')}}
)

select * from collection_stages