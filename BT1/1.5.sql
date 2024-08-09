use `employees`;

select avg(salaries.`emp_no`) as avgSalary, titles.`title`
from salaries
inner join titles on salaries.`emp_no` = titles.`emp_no`
where (salaries.`from_date` between titles.`from_date` and titles.`to_date`)
	and (salaries.`to_date` between titles.`from_date` and titles.`to_date`)
	and (date('1996-07-25')  between salaries.`from_date` and salaries.`to_date`)
group by titles.`title`;