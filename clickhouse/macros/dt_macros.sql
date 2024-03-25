{% macro coalesce_to_uuid(column_name) %}
    {% if target.type == 'clickhouse' %}
        coalesce(toUUID({{ column_name }}), toUUID('{{ var("missing_uuid") }}')) as {{ column_name }}
    {% else %}
        
        coalesce(cast({{ column_name }} as uuid), '{{ var("missing_uuid") }}') as {{ column_name }}
    {% endif %}
{% endmacro %}


{% macro coalesce_to_timestamp(column_name) %}
    case
        when {{ column_name }} is null then null
        else coalesce(cast({{ column_name }} as timestamp), {{ column_name }})
    end as {{ column_name }}
{% endmacro %}


{% macro coalesce_to_date(column_name) %}
    case
    when {{ column_name }} is null then null
    else toDate({{ column_name }}) end as {{ column_name }}
{% endmacro %}