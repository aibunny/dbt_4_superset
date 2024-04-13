with whatsapp_mart as (
      select
            *
        from
            {{ref('int_whatsapp')}}
        
        union all 

        select
            *
        from
            {{ref('int_new_whatsapp')}}
    
)

select * from whatsapp_mart