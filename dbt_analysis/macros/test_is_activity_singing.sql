{% test test_is_activity_singing(model, column_name) %}

with validation as (

    select
        {{ column_name }} as activity_name

    from {{ model }}

),

validation_errors as (

    select
        activity_name

    from validation
    
    where activity_name like '%special%'

)

select *
from validation_errors

{% endtest %}