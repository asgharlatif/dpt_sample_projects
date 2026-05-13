with studentinformation as
(
	select dept_id , count(*) as total_enrolled from {{ ref('student') }} 
	group by dept_id 
)

select d.dept_name , coalesce(s.total_enrolled,0) from {{ ref('department') }} d left join studentinformation s
on
d.dept_id = s.dept_id
group by 
d.dept_name,coalesce(s.total_enrolled,0)