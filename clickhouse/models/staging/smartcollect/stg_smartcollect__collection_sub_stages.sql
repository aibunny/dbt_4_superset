with collection_sub_stages as (
    select 
        *
    from {{source('smartcollect','collection_sub_stages')}}
)

select * from collection_sub_stages