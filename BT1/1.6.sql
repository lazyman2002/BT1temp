select sum(tax) 
from (
	select
		case
			when `salary` <= 40000 then `salary` * 0
			when `salary` between 40001 and 60000 then `salary` * 0.05
			when `salary` between 60001 and 90000 then `salary` * 0.1
			when `salary` > 90000 then `salary` * 0.15
		end as tax
		from `salaries`
) as temp
