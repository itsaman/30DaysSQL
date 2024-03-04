create table mountain_huts 
(
	id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;
create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);

select * from mountain_huts;

-------------

with cte1 as (
    select hut1 as source, hut2 as end_hut, name as source_name, altitude as source_altitude
    from trails tr
    join mountain_huts mh
    on tr.hut1 = mh.id
), cte2 as (
select t.*, mh2.name as end_hut_name, mh2.altitude as end_hut_altitude,
case when mh2.altitude >  source_altitude then 0 else 1 end as altitude_flag
from cte1 t
join mountain_huts mh2 
on t.end_hut = mh2.id
), cte3 as (
select 
    case when altitude_flag = 1 then source_name else end_hut_name end as source_name,
    case when altitude_flag = 1 then source else end_hut end as start_hut,
    case when altitude_flag = 1 then end_hut_name else source_name end as end_hut_name,
    case when altitude_flag = 1 then end_hut else source end as end_hut
from cte2)
select * from cte3 c1
join cte3 c2 on c1.end_hut = c2.start_hut






