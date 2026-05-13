with dataset as
( 
select rc.visited_on ,SUM(amount) as total from {{ ref('restaurant_customer') }} rc group by rc.visited_on
)
,
refinedataset as
(
	select visited_on , total,
	avg(total) over (order by visited_on rows between 6 preceding and current row) as average_amount,
	avg(total) over (order by visited_on range between interval '6 days' preceding and current row) as average_amount1,
	count(*) over (order by visited_on range between interval '6 days' preceding and current row) as no_of_days
	from dataset	
)

select visited_on , total , round(average_amount, 2) as average_amount from refinedataset where no_of_days > 6