{% set sql_statement %}
    select publication, work from {{ ref('map_publication-openaire2work-openalex') }};
{% endset %}
{%- set map = dbt_utils.get_query_results_as_dict(sql_statement) -%}

SELECT
{% set results = run_query(sql_statement) %}

{% if execute %}
{% set results_list = results.rows %}
{% else %}
{% set results_list = [] %}
{% endif %}

{% for pub in results_list %}
    {% if pub.1 %}
        {{- pub.1 }} 
            {% if pub.0 %}
                as {{ pub.0 }}
            {% endif %}
        {% if not loop.last %}
            ,
        {% endif %}
    {% endif %}
{% endfor %}
FROM {{ ref('raw_work_openalex') }} limit 10
