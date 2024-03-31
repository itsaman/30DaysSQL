--DAY 28
 --Find length of comma seperated values in items field

drop table if exists item;
create table item
(
	id		int,
	items	varchar(50)
);
insert into item values(1, '22,122,1022');
insert into item values(2, ',6,0,9999');
insert into item values(3, '100,2000,2');
insert into item values(4, '4,44,444,4444');

select * from item;

with temp as (
select id,  split(items,',') as items_size from item
),temp2 as (
select id, value, length(value) as item_len from temp, lateral flatten(INPUT => temp.items_size)
)
select  id, listagg(item_len, ',') from temp2 group by id order by id
