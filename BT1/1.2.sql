use `employees`;

with tmp as(
	select tmpTable.avgSalary, tmpTable.`dept_no`, ROW_NUMBER() OVER (ORDER BY avgSalary DESC) as row_num
		from(
			select avg(`salary`) as avgSalary, departments.`dept_no`
				from `salaries`
					left join `dept_emp` on `salaries`.`emp_no` = `dept_emp`.`emp_no`
                    inner join `employees` on `salaries`.`emp_no` = `employees`.`emp_no` 
					inner join `departments` on `dept_emp`.`dept_no` = `departments`.`dept_no`
					where year(`employees`.`hire_date`) > 1994
                        and (date('1996-07-25')  between date(`salaries`.`from_date`) and date(`salaries`.`to_date`))
				group by `departments`.`dept_no`
		) as tmpTable
)
select `avgSalary`, `dept_no` from tmp where row_num = 1;
    
    
