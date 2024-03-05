drop table if exists salary;
create table salary
(
	emp_id		int,
	emp_name	varchar(30),
	base_salary	int
);
insert into salary values(1, 'Rohan', 5000);
insert into salary values(2, 'Alex', 6000);
insert into salary values(3, 'Maryam', 7000);


drop table if exists income;
create table income
(
	id			int,
	income		varchar(20),
	percentage	int
);
insert into income values(1,'Basic', 100);
insert into income values(2,'Allowance', 4);
insert into income values(3,'Others', 6);


drop table if exists deduction;
create table deduction
(
	id			int,
	deduction	varchar(20),
	percentage	int
);
insert into deduction values(1,'Insurance', 5);
insert into deduction values(2,'Health', 6);
insert into deduction values(3,'House', 4);


select * from salary;
select * from income;
select * from deduction;


----
Create or replace temp table emp_transaction as 
with temp as (
select * from income
union 
select * from deduction
), temp2 as (
select emp_id, emp_name, base_salary, income as trxn_type, percentage,
(base_salary*percentage)/100 as amount
from salary, temp
order by income, emp_id
)
select emp_id, emp_name,trxn_type, amount from temp2;


With cte as (
select emp_name,
max(case when trxn_type  = 'Basic' then Amount else 0 end)as Basic,
max(case when trxn_type  = 'Allowance' then Amount else 0 end)as Allowance,
max(case when trxn_type  = 'Others' then Amount else 0 end)as Others,
max(case when trxn_type  = 'Insurance' then Amount else 0 end)as Insurance,
max(case when trxn_type  = 'Health' then Amount else 0 end)as Health,
max(case when trxn_type  = 'House' then Amount else 0 end)as House
from emp_transaction
group by emp_name
)
select emp_name, basic, Allowance, Others, (Basic+Allowance+Others) as Gross, 
Insurance, Health, House, (Insurance+Health+House) as Deductions,
(Basic+Allowance+Others)- (Insurance+Health+House) as Net_pay
from cte
order by emp_name;
