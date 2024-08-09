use `employees`;

select sum(salary) as total,`dept_emp`.`dept_no`  from `salaries`
	left join `dept_emp` on `salaries`.`emp_no` = `dept_emp`.`emp_no`
	where date('1996-07-25') between salaries.`from_date` and salaries.`to_date`
		and date('1996-07-25')  between dept_emp.`from_date` and dept_emp.`to_date`
    group by `dept_emp`.`dept_no`
    having total >300000;