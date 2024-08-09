use `employees`;

select count(distinct(dept_emp.`emp_no`)) as result
from (
	select dept_manager.`dept_no`, greatest(titles.`from_date`,dept_manager.`from_date`) as from_date, least(titles.`to_date`,dept_manager.`to_date`) as to_date
	from employees
		inner join titles on employees.`emp_no` = titles.`emp_no`
		join dept_manager on employees.`emp_no` = dept_manager.`emp_no`
        where employees.`first_name` = 'Margareta'
			and employees.`last_name` = 'Markovitch'
			and titles.`title` = 'Manager'
	) as temp2
	join dept_emp on temp2.`dept_no` = dept_emp.`dept_no`
	where ((dept_emp.`from_date` >= temp2.`from_date` and  dept_emp.`from_date` <= temp2.`to_date`)
		or  (dept_emp.`to_date` >= temp2.`from_date` and  dept_emp.`to_date` <= temp2.`to_date`))
