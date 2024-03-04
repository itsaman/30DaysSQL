DROP TABLE IF EXISTS FOOTER;
CREATE TABLE FOOTER 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 


----


SELECT *, 
case when length is null then last_value(length)over(order by id) end as length1
FROM FOOTER;

select * from 
(select car from footer where car is not null order by id desc limit 1) cars
cross join (select length from footer where length is not null order by id desc limit 1) lengths
cross join(select width from footer where width is not null order by id desc limit 1) widths
cross join (select height from footer where height is not null order by id desc limit 1) heights;

select * from 
(select split(listagg(car, ',') within group (order by id desc), ',')[0] as car from footer) cars
cross join (select split(listagg(length, ',') within group (order by id desc), ',')[0] as length from footer) lengths 
cross join (select split(listagg(width, ',') within group (order by id desc), ',')[0] as width from footer) widths
cross join (select split(listagg(height, ',') within group (order by id desc), ',')[0] as height from footer) heights









