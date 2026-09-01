-------------------TASK 1
create database week8;
use  week8;

-------------------TASK 2
CREATE TABLE IF NOT EXISTS sailors(
   sid INT PRIMARY KEY ,
   sname char(50) ,
   rating int ,
   age DECIMAL(3,1) 
);

CREATE TABLE IF NOT EXISTS boats(
   bid INT PRIMARY KEY ,
   bname char(50) ,
   bcolor char(50) 
   
);

CREATE TABLE IF NOT EXISTS reserves(
   sid INT ,
   bid int ,
   day char(50) ,
   CONSTRAINT prime PRIMARY KEY (sid , bid , day),
   CONSTRAINT refer_sailor foreign KEY (sid) references  sailors(sid),
   CONSTRAINT refer_boats foreign KEY (bid) references  boats(bid)
);

-------------------TASK 3

--set global local_infile=1;

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 8/sailors.csv" 
INTO TABLE sailors
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 8/boats.csv" 
INTO TABLE boats
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 8/reserves.csv" 
INTO TABLE reserves
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

----------task 4

---1

CREATE view view1 as
select sid , rating
from sailors;

INSERT into view1 values (91,7);
insert into view1 values(92,8);
insert into view1 values(93,9);
insert into view1 values(94,10);
insert into view1 values(22,8);   --Duplicate entry '22' for key 'sailors.PRIMARY'

UPDATE view1
set rating  = 8
where sid  = 91;

delete From view1 
where sid = 91;


---2

CREATE view view2 as
select *
from boats
WHERE bcolor= 'green';

insert into view2 values(205, 'River Mania', 'green');
insert into view2 values(206, 'green-bird', 'green');
insert into view2 values(207, 'blue-warriors', 'blue');

CREATE view view3 as
select *
from boats
WHERE bcolor= 'green'
with check option;

insert into view3 values(207, 'blue-warriors', 'blue'); --CHECK OPTION failed 'week8.view3'


---3


CREATE view view4 as
select S.sid, S.rating , B.bid, B.bname
from (sailors as S natural join reserves as R) natural join boats as B ;

insert into view4(sid, rating)
values (80,8);

insert into view4(bid, bname)
values (105,'Lucky Lake');

update view4 
set bname='Jumper' 
where bid=101;

update view4 
set bname='Interlake' 
where bid=101;

----non updatable views

--1

create view view5 as
select S.sid , S.sname, S.rating , B.bid, B.bname
from sailors as S natural join reserves as R natural join boats as B
where rating in (
   select max(rating)
   from sailors natural join reserves natural join boats
);


insert into view5(sid, sname, rating)
 values(80,'best sailor',10);
-- Error : The target table view5 of the INSERT is not insertable-into

update view5 set rating=-9 where sid=74;
--ERROR 1288 (HY000): The target table view5 of the UPDATE is not updatable


delete from view5 where sid=74;
-- ERROR 1395 (HY000): Can not delete from join view 'week8.view5'

update view5 set bname='Can I get updated?' where bid=102;
-- ERROR 1288 (HY000): The target table view5 of the UPDATE is not updatable


---2

create view view6 as
select distinct rating 
from sailors;

insert into view6 values (2);
--ERROR 1471 (HY000): The target table view6 of the INSERT is not insertable-into


update view6 set rating=-7 where ratng=7;
-- Error : The target table view6 of the UPDATE is not updatable

delete from view6 where rating=7;
-- Error :The target table view6 of the DELETE is not updatable



--3


create view view7 as
select * from 
sailors natural join reserves natural join boats
where bid in (
   select bid 
   from sailors natural join reserves natural join boats
   group by bid 
   having max(rating) = min(rating)
);

---taking all the boats which are reserbed by all the sailors with same ratings USING THIS ONE IS ERROR AS SLEECT * AND GROUPING ARRITRIBUTES ARE NOT COMPATABLE
-- create view view7 as 
-- select *
-- from sailors natural join reserves
-- group by rating;

insert into view7(sid, sname,rating,age) values(80,'budding sailor',10,25);
--The target table view7 of the INSERT is not insertable-into

update view7 set rating=6 where rating=8;
--The target table view7 of the UPDATE is not updatable

delete from view7 where rating=7;
--Can not delete from join view 'week8.view7'



--4

create view view77 as
select * from 
sailors natural join reserves natural join boats
where bid in (
   select bid 
   from sailors natural join reserves natural join boats
   group by bid 
   having max(rating) = min(rating) and age > 36
);

--- THIS GIVES AN ERROR AS SELECTION ATTRIBUTES NOT COMPATIBLE WITH GROUPING ATTRIBUTES
-- create view view7_7 as 
-- select * 
-- from sailors natural join reserves
-- GROUP BY rating 
-- having age > 36;

insert into view77(sid, sname,rating,age) values(80,'budding sailor',10,25);
--The target table view77 of the INSERT is not insertable-into

update view77 set rating=6 where rating=8;
--The target table view77 of the UPDATE is not updatable

delete from view77 where rating=7;
--Can not delete from join view 'week8.view77'



--5

create view view8 as
select sid , sname , bid , bcolor
from sailors natural join boats natural join reserves
where bcolor = 'green'
UNION
select sid , sname , bid , bcolor
from sailors natural join boats natural join reserves
where bcolor = 'blue';

insert into view8(sid , sname , bid , bcolor) values(81,'union view insert',110, 'green');
-- Error : The target table view8 of the INSERT is not insertable-into

update view8 set sname='union view update' where sid=81;
-- Error : The target table view8 of the UPDATE is not updatable

delete from view8 where sid=22;
-- Error : The target table view8 of the DELETE is not updatable



----- views using views

create view view9 as
select rating from view1;

insert into view9 values(7); --Field of view 'week8.view9' underlying table doesn't have a default value
insert into view9 values(8); --Field of view 'week8.view9' underlying table doesn't have a default value
insert into view9 values(9);--Field of view 'week8.view9' underlying table doesn't have a default value
insert into view9 values(10);--Field of view 'week8.view9' underlying table doesn't have a default value
insert into view9 values(8);--Field of view 'week8.view9' underlying table doesn't have a default value


update view9 
set rating = 9 
where rating = 8;

delete from view9 
where rating=10;

create view view10 as
select sid,bname,day 
from view4 natural join reserves;

----altering original tables

alter table sailors
rename column rating to rting;

select * from view1; --View 'week8.view1' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them

select * from view4;--View 'week8.view1' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them

select * from view5;--View 'week8.view1' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them

select * from view6;--View 'week8.view1' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them

select * from view9;--View 'week8.view1' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them

select * from view7;--View 'week8.view1' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them

select * from view77;--View 'week8.view1' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them

alter table sailors 
rename column rting to rating;

select * from view1;
select * from view4;
select * from view5;
select * from view6;
select * from view7;
select * from view77;
select * from view9;
select * from view8; --- all fine now

alter table sailors
drop column rating;

select * from view1;
select * from view4;
select * from view5;
select * from view6;
select * from view7;
select * from view77;
select * from view9;
select * from view11; ---- all the above have error -----  View 'week8.view77' references invalid table(s) or column(s) or function(s) or definer/invoker of view lack rights to use them


----type conversions

CREATE TABLE IF NOT EXISTS sailors_1(
   sid INT PRIMARY KEY ,
   sname char(50) ,
   rating int ,
   age DECIMAL(3,1) 
);

CREATE TABLE IF NOT EXISTS boats_1(
   bid INT PRIMARY KEY ,
   bname char(50) ,
   bcolor char(50) 
   
);

CREATE TABLE IF NOT EXISTS reserves_1(
   sid INT references sailors_1(sid),
   bid int references boats_1(bid),
   day char(50) ,
   CONSTRAINT prime PRIMARY KEY (sid , bid , day)
);



LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 8/sailors.csv" 
INTO TABLE sailors_1
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 8/boats.csv" 
INTO TABLE boats_1
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 8/reserves.csv" 
INTO TABLE reserves_1
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';


alter table reserves_1
modify sid smallint;

alter table sailors_1
modify sid smallint;

alter table reserves_1
modify bid char(3);

alter table boats_1
modify bid char(3);

alter table boats_1 
modify bcolor char(5);













