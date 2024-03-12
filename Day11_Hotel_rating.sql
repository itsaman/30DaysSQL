drop table if exists hotel_ratings;
create table hotel_ratings
(
	hotel 		varchar(30),
	year		int,
	rating 		FLOAT
);
insert into hotel_ratings values('Radisson Blu', 2020, 4.8);
insert into hotel_ratings values('Radisson Blu', 2021, 3.5);
insert into hotel_ratings values('Radisson Blu', 2022, 3.2);
insert into hotel_ratings values('Radisson Blu', 2023, 3.8);
insert into hotel_ratings values('InterContinental', 2020, 4.2);
insert into hotel_ratings values('InterContinental', 2021, 4.5);
insert into hotel_ratings values('InterContinental', 2022, 1.5);
insert into hotel_ratings values('InterContinental', 2023, 3.8);

SELECT * FROM hotel_ratings;


With cte as (
  select hotel, year, rating, 
  AVG(rating)OVER(PARTITION BY hotel) as base,
  abs(rating - AVG(rating)OVER(PARTITION BY hotel)) as difference
from hotel_ratings)
select *, 
    dense_rank()over(partition by hotel order by difference desc) as dk 
from cte
qualify dk = 1
