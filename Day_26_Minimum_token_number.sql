drop table if exists tokens;
create table tokens
(
	token_num	int,
	customer	varchar(20)
);
insert into tokens values(1, 'Maryam');
insert into tokens values(2, 'Rocky');
insert into tokens values(3, 'John');
insert into tokens values(3, 'John');
insert into tokens values(2, 'Arya');
insert into tokens values(1, 'Pascal');
insert into tokens values(9, 'Kate');
insert into tokens values(9, 'Ibrahim');
insert into tokens values(8, 'Lilly');
insert into tokens values(8, 'Lilly');
insert into tokens values(5, 'Shane');

with temp as (
select *, dense_rank()over(partition by token_num order by customer) as dk
from tokens), temp2 as (
select token_num, max(dk) from temp group by token_num having max(dk) = 1
)
select min(token_num) from temp2 
