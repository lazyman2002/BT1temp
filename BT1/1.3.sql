use `employees`;

DELIMITER $$
drop function if exists countMT $$
create function countMT (from_date DATE,to_date DATE, salary INT)
returns int
DETERMINISTIC
BEGIN
	DECLARE start_date DATE;
    DECLARE days_counter INT DEFAULT 0;
	set start_date = date(from_date);
    if(day(start_date)!=25)
		then 
			set days_counter = days_counter +1;
            while (day(start_date)!=25)do
				set start_date = DATE_ADD(start_date, INTERVAL 1 day);
            end while;
    end if;
    while (start_date < to_date) do
		set days_counter = days_counter +1;
        set start_date = DATE_ADD(start_date, INTERVAL 1 MONTH);
	end while;
    return days_counter * salary;
END $$
DELIMITER ;

select sum(SLR) from (
	select countMT (greatest(`titles`.`from_date`, `salaries`.`from_date`) ,least(`titles`.`to_date`, `salaries`.`to_date`) , `salaries`.`salary`) as SLR from `titles`  join `salaries`
	where `titles`.`emp_no` = 10005 and `salaries`.`emp_no` = 10005 and `titles`.`title` = 'Staff') as tsp;

