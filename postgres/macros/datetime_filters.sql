{% macro truncate_datetime(datetime_string) %}
    {% set truncated_string = left(datetime_string, 19) %}
    {{ truncated_string }}
{% endmacro %}
