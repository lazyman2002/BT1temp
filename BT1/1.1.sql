with final as(
	select row_number() over(PARTITION BY tempView.`dept_no` ORDER BY tempView.`salary`) as STT, tempView.*
		from (	
        select `salaries`.`emp_no`, `salaries`.`salary`, `dept_emp`.`dept_no`
		from `salaries`
			left join `dept_emp` 
			on `salaries`.`emp_no` = `dept_emp`.`emp_no`
			inner join `employees`
			on `salaries`.`emp_no` = `employees`.`emp_no`
			where year(`employees`.`hire_date`) > 1994
				and date('1996-07-25') between date(`salaries`.`from_date`)  and date(`salaries`.`to_date`)) as tempView
)
select final.`emp_no`, final.`salary`, final.`dept_no` from final
	where STT = 1;
    