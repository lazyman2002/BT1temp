use `employees`;

select employees.`emp_no`
	from dept_emp 
	right join employees on dept_emp.`emp_no` = employees.`emp_no`
	where employees.`gender` like 'M' and dept_emp.`dept_no` like 'd002'
union 
select employees.`emp_no` 
	from dept_emp 
	right join employees on dept_emp.`emp_no` = employees.`emp_no`
	where employees.`gender` like 'M' and dept_emp.`dept_no` like 'd003';