with datatable as
(
	select 
	f.activity , 
	count(*) as total_activities 
	from {{ source('raw_sources_1', 'friends') }} f 
	group by f.activity
)


select * 
from datatable
where total_activities not in (select max(total_activities) from datatable)
and 
 total_activities not in (select min(total_activities) from datatable)