use `employees`;
select t1.`emp_no`
	from `titles` as t1
    right join `titles` as t2 on t1.`emp_no`  = t2.`emp_no`
		where t2.`to_date` = date('9999-01-01')
	group by t1.`emp_no`
	having count(t1.`emp_no`) > 1;