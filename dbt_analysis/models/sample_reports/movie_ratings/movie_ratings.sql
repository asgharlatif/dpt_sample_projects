with mov_user_data as
(
	select u."name" as moviename   from {{ ref('movierating') }}  m  
	inner join {{ ref('users') }} u  on
	m.user_id = u.user_id 
	group by u."name"
	order by count(*) desc,u."name" asc
	limit 1
)
,
mov_rating_data as
(
	select m2.title	
	from {{ ref('movierating') }} m inner join {{ ref('movies') }} m2 on
	m.movie_id = m2.movie_id 
	where EXTRACT(MONTH FROM created_at) = 2 and EXTRACT(YEAR FROM created_at) = 2020
	group by m2.title 
	order by avg(rating) desc,m2.title asc
	limit 1
)

select moviename from mov_user_data
union all
select title from mov_rating_data