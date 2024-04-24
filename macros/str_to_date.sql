{% macro str_to_date(str_date) %}
{# {{str_date}} #}
(CASE 
    WHEN ({{str_date}} ~ '^\d{4}$') THEN CONCAT({{str_date}},'-01-01')
    WHEN ({{str_date}} ~ '^\d{4}-\d{1,2}$') THEN CONCAT({{str_date}},'-01')
    ELSE {{str_date}}
END)::date

{% endmacro %}
