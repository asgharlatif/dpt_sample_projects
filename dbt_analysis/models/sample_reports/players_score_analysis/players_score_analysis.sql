with dataset as
(
	select sum(score_points) as total_score , gender , day from 
    {{ ref('scores') }}
	group by gender , day
	order by gender , day
)

select day,gender,total_score,

sum(total_score) over (partition by gender order by day) as running_total

from dataset

