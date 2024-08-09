use `employees`;


DELIMITER $$

drop function if exists countMT $$

create function countMT (from_date DATE,to_date DATE, salary INT)
returns int
DETERMINISTIC
BEGIN
	DECLARE start_date DATE;
    DECLARE days_counter INT DEFAULT 0;
	set start_date = date('1996-01-25');
    while start_date < from_date do
		if (start_date < from_date)	then set start_date = DATE_ADD(start_date, INTERVAL 1 MONTH);
        end if;
	end while;
    while (start_date < date('1997-01-01') and start_date < to_date) do
		set days_counter = days_counter +1;
        set start_date = DATE_ADD(start_date, INTERVAL 1 MONTH);
	end while;
    return days_counter * salary;
END $$
DELIMITER ;

select sum(EMPtotalSalary), `dept_no` from (
	select 	`salaries`.`emp_no`, 
			greatest(`salaries`.`from_date`, `dept_emp`.`from_date`) as `f_date`, 
            least(`salaries`.`to_date`, `dept_emp`.`to_date`) as `t_date`, 
            countMT(greatest(`salaries`.`from_date`, `dept_emp`.`from_date`), least(`salaries`.`to_date`, `dept_emp`.`to_date`), `salaries`.`salary`) as EMPtotalSalary, 
            `dept_emp`.`dept_no`
		from `salaries`
		inner join `dept_emp` on `salaries`.`emp_no` = `dept_emp`.`emp_no`
        where 1996 between year(salaries.`from_date`) and year(salaries.`to_date`)
			and 1996 between year(dept_emp.`from_date`) and year(dept_emp.`to_date`)
        ) as result
	group by result.`dept_no`;