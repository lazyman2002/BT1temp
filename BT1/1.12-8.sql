use `employees`;

with dept_total as(
	select * from dept_emp
    union
    select * from dept_manager
) 
select dept_total.`emp_no`
from titles
	join dept_total on  titles.`emp_no` = dept_total.`emp_no`
    where dept_total.to_date between titles.from_date and titles.to_date
		or dept_total.from_date between titles.from_date and titles.to_date
	group by dept_total.`emp_no`
    having count(distinct(`title`)) > 1 and count(distinct(`dept_no`)) >1
    ;