CREATE table if not EXISTS location (
   location_id int primary key,
   city char(10),
   state char(2),
   country char (20)
);

CREATE table if not EXISTS product (
   product_id int primary key,
   product_name char(10),
   category char(2),
   price int
);

drop table sale;
CREATE table if not EXISTS sale (
   product_id int ,
   time_id int,
   location_id int,
   sales int,
   primary key(product_id, time_id, location_id)
);

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/LAB 13/location.csv" 
INTO TABLE location
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n'
ignore 1 LINES;

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/LAB 13/product.csv" 
INTO TABLE product
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n'
ignore 1 LINES;

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/LAB 13/sale.csv" 
INTO TABLE sale
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n'
ignore 1 LINES;

------task 04 a. 

drop table year_state_01;
CREATE table if not EXISTS year_state_01 (
   year char (20),
   WI int,
   CA int,
   total int
);

INSERT into year_state_01 values (
   '1995' 
   , 
      (select sum(sales)
      from location natural join sale
      where time_id = 1995 and state = 'WI')
   ,
      (select sum(sales)
      from location natural join sale
       where time_id = 1995 and state = 'CA'
      )
   ,
      (select sum(sales)
      from location natural join sale
       where time_id = 1995
      )
);

INSERT into year_state_01 values (
   '1995' 
   , 
      (select sum(sales)
      from location natural join sale
      where time_id = 1996 and state = 'WI')
   ,
      (select sum(sales)
      from location natural join sale
       where time_id = 1996 and state = 'CA'
      )
   ,
      (select sum(sales)
      from location natural join sale
       where time_id = 1996
      )
);

INSERT into year_state_01 values (
   '1995' 
   , 
      (select sum(sales)
      from location natural join sale
      where time_id = 1997 and state = 'WI')
   ,
      (select sum(sales)
      from location natural join sale
       where time_id = 1997 and state = 'CA'
      )
   ,
      (select sum(sales)
      from location natural join sale
       where time_id = 1997
      )
);

INSERT into year_state_01 values (
   'total' 
   , 
      (select sum(sales)
      from location natural join sale
      where state = 'WI')
   ,
      (select sum(sales)
      from location natural join sale
         where state = 'CA'
      )
   ,
      (select sum(sales)
      from location natural join sale
      )
);

select * from year_state_01;


------task 04 b. 

-- drop table year_state_02_01;
-- CREATE table if not EXISTS year_state_02_01 (
--    year char (20),
--    WI int,
--    CA int
-- );


CREATE TABLE year_state_02_01 AS 
SELECT time_id as YEAR,
   SUM( CASE when state = "WI" THEN sales ELSE 0 END ) AS WI,
   SUM( CASE when state = "CA" THEN sales ELSE 0 END ) AS CA
FROM sale natural join location
GROUP BY time_id;


CREATE TABLE year_state_02_02 AS 
select WI + CA
from year_state_02_01;

drop table year_state_02_03;
CREATE TABLE year_state_02_03 AS 
select 'total', sum(WI) as sum_wi , sum(CA) as sum_ca
from year_state_02_01;

CREATE TABLE year_state_02_04 AS 
select sum_wi + sum_ca
from year_state_02_03;

------task 04 c. 

create table year_state_03 as

select time_id as year , sum(case when state = 'WI' then sales else 0 end ) as WI , sum( case when state = 'CA' then sales else 0 end) as CA, sum(sales) as total
from sale natural join location
group by time_id

UNION

select 'total' as year , sum(case when state = 'WI' then sales else 0 end ) as WI , sum( case when state = 'CA' then sales else 0 end) as CA, sum(sales) as total
from sale natural join location;


------task 04 d. 

CREATE TABLE year_state_04
SELECT 
        IF(GROUPING(time_id),'TOTAL', time_id) AS YEAR,
        sum(case when state = 'WI' THEN sales else 0 end) AS 'WI',
        sum(case when state = 'CA' THEN sales else 0 end) AS 'CA',
        SUM(sales) as 'Total'
from sale natural join location
group by time_id WITH ROLLUP;