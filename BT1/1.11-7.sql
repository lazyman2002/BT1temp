use `employees`;

with tmp as (
	select row_number() over(PARTITION BY current_working.`dept_no` ORDER BY current_working.`salary`) as STT, current_working.*
    from (
    	select titles.`emp_no`, salaries.`salary`, dept_emp.`dept_no`
        from titles
		left join salaries on titles.`emp_no` = salaries.`emp_no`
		left join dept_emp on titles.`emp_no` = dept_emp.`emp_no`
		where titles.`to_date` = date('9999-01-01')
			and titles.`title` = 'Staff'
    ) as current_working
)
select `emp_no`, `salary`, `dept_no` from tmp where STT<=5;
