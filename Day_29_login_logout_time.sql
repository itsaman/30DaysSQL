-- day 29
/*
PROBLEM STATEMENT: Given table provides login and logoff details of one user.
Generate a report to reqpresent the different periods (in mins) when user was logged in.
*/
drop table if exists login_details;
create table login_details
(
	times	time,
	status	varchar(3)
);
insert into login_details values('10:00:00', 'on');
insert into login_details values('10:01:00', 'on');
insert into login_details values('10:02:00', 'on');
insert into login_details values('10:03:00', 'off');
insert into login_details values('10:04:00', 'on');
insert into login_details values('10:05:00', 'on');
insert into login_details values('10:06:00', 'off');
insert into login_details values('10:07:00', 'off');
insert into login_details values('10:08:00', 'off');
insert into login_details values('10:09:00', 'on');
insert into login_details values('10:10:00', 'on');
insert into login_details values('10:11:00', 'on');
insert into login_details values('10:12:00', 'on');
insert into login_details values('10:13:00', 'off');
insert into login_details values('10:14:00', 'off');
insert into login_details values('10:15:00', 'on');
insert into login_details values('10:16:00', 'off');
insert into login_details values('10:17:00', 'off');

select * from login_details;

with temp as (
    select *,
    row_number()over(order by times) as rn1
    from login_details
), final as (
    select *, row_number()over(order by times) as rn2, rn1-row_number()over(order by times) as difference
    from temp
    where status = 'on'
), temp2 as (
    select times, 
    first_value(times)over(partition by difference order by times) as log_on, 
    last_value(times)over(partition by difference order by times) as log_out, 
    count(difference)over(partition by difference order by times) as difference
    from final
), final2 as (
    select log_on,dateadd(minute,1,log_out) as log_out ,difference, dense_rank()over(partition by log_out order by difference desc) as dk
    from temp2
    qualify dk =1
)
select log_on, log_out, difference from final2
order by log_on;
