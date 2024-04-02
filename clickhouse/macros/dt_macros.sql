{% macro coalesce_to_uuid(column_name) %}
    {% if target.type == 'clickhouse' %}
        coalesce(toUUID({{ column_name }}), toUUID('{{ var("missing_uuid") }}')) as {{ column_name }}
    {% else %}
        coalesce( 
          cast({{ column_name }} as uuid),
          '{{ var("missing_uuid") }}'
        ) as {{ column_name }}
    {% endif %}

{% endmacro %}




{% macro runtime(run_started_at, target_type) %}
  {% if target_type == 'clickhouse' %}
    toDateTime64(parseDateTimeBestEffort('{{ run_started_at | trim }}'), 3, 'UTC')
  {% else %}
    '{{ run_started_at }}'
  {% endif %}
{% endmacro %}




{% macro default_uuid(target_type) %}
  {% if target_type == 'clickhouse' %}
    toUUID('{{ var("missing_uuid") }}')
  {% else %}
    cast('{{ var("missing_uuid") }}' as uuid) 
  {% endif %}
{% endmacro %}



{% macro coalesce_to_timestamp(column_name) %}
    case
        when {{ column_name }} is null then null
        else coalesce(cast({{ column_name }} as timestamp), {{ column_name }})
    end as {{ column_name }}
{% endmacro %}



{% macro coalesce_to_date(column_name) %}
  {%if target.type == 'clickhouse'%}
    case
    when {{ column_name }} is null then null
    else toDate({{ column_name }}) end as {{ column_name }}
  {% else %}
    case
    when {{ column_name }} is null then null
    else TO_DATE({{ column_name }}::text,'YYYYMMDD') end as {{ column_name }}
  {% endif %}

{% endmacro %}




{% macro get_active_value(target_type) %}
  {% if target_type == 'clickhouse' %}
    1
  {% else %}
    True
  {% endif %}
{% endmacro %}



{% macro get_source_schema(target_type)%}
  {%if target_type == 'clickhouse'%}}
    'smartcollect'
  {%else%}
    'public'
  {%endif%}
{% endmacro%}