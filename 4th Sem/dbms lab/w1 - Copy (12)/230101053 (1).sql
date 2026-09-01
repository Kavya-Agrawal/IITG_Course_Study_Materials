
--- slave is Durgesh Shelke 230101093


create table if not EXISTS sailor (
   sid int primary key,
   sname char(50) ,
   rating int,
   age decimal (3,1)
);

create table if not EXISTS boat (
   bid int primary key,
   bname char(50) ,
   bcolor char(50)
);

CREATE TABLE if NOT EXISTS reserves (
   sid int ,
   bid int ,
   day date,
   primary key (sid, bid, day),
   foreign key (sid) references sailor(sid)  on update cascade on delete cascade,
   foreign key (bid) references boat(bid)  on update cascade on delete cascade
);
    

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 12/sailors.csv" 
INTO TABLE sailor
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 12/boats.csv" 
INTO TABLE boat
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 12/reserves.csv" 
INTO TABLE reserves
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

ALTER TABLE sailor ADD COLUMN earning INT DEFAULT 100 AFTER sname;
ALTER TABLE boat ADD COLUMN make CHAR(20) DEFAULT 'Toyota' AFTER bcolor;
ALTER TABLE reserves ADD COLUMN amount INT DEFAULT 10 AFTER day;
 
-- Insert random data
INSERT INTO sailor VALUES (101,  'RandomSailor', 3000 , 8 , 50 );
INSERT INTO boat VALUES (201, 'RandomBoat', 'yellow', 'randomMaker');
INSERT INTO reserve VALUES (101, 201, '2025-04-05', 500 );

ALTER TABLE sailor drop COLUMN earning ;
ALTER TABLE boat drop COLUMN make ;
ALTER TABLE reserves drop COLUMN amount;

DELIMITER $$
CREATE PROCEDURE insert_sailors()
BEGIN
   DECLARE i INT DEFAULT 0;
   WHILE i < 10000 DO
      INSERT INTO sailor (sid, sname, rating, age)
      VALUES (
         1 + FLOOR(RAND() * 1000000),  -- giving error as primary key constraint generating randomly
         CONCAT( i , 'Sailor', SUBSTRING(MD5(RAND()) , 1 , 8) ),
         FLOOR(RAND() * 10),
         FLOOR(RAND() * 50) + 18
      );
      SET i = i + 1;
   END WHILE;
END$$
DELIMITER ;

call insert_sailors();


DELIMITER $$
CREATE TRIGGER after_boat_insert
AFTER INSERT ON boat
FOR EACH ROW
BEGIN
   DECLARE counter INT DEFAULT 0;
   declare counterrand int default 0;

   set counterrand = 1 + floor(rand() * 10);

   WHILE counter < (10 + counterrand) DO
      INSERT INTO reserves (sid, bid, day)
      VALUES (
         (SELECT sid FROM sailor ORDER BY RAND() LIMIT 1),
         NEW.bid,
         DATE_ADD(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY)
      );
      SET counter = counter + 1;
   END WHILE;
END$$

DELIMITER ;

insert into  boat values (110 , 'Kavya' , 'green');
insert into  boat values (111 , 'Durgesh' , 'green');


create view sailor_reseres_boat as
select sname, bname, day
from sailor natural join boat natural join reserves;

------------------------------------------------------------------------------



create table if not EXISTS sailor (
   sid int primary key,
   sname char(50) ,
   rating int,
   age decimal (3,1)
);

create table if not EXISTS boat (
   bid int primary key,
   bname char(50) ,
   bcolor char(50)
);

CREATE TABLE if NOT EXISTS reserves (
   sid int ,
   bid int ,
   day date,
   primary key (sid, bid, day),
   foreign key (sid) references sailor(sid)  on update cascade on delete cascade,
   foreign key (bid) references boat(bid)  on update cascade on delete cascade
);

CREATE TABLE if NOT EXISTS reserves_details (
   sid int,
   bid int,
   day date,
   primary key (sid, bid, day),
   foreign key (sid) references sailor(sid)  on update cascade on delete cascade,
   foreign key (bid) references boat(bid)  on update cascade on delete cascade
);


LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 12/sailors.csv" 
INTO TABLE sailor
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 12/boats.csv" 
INTO TABLE boat
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';

LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 12/reserves.csv" 
INTO TABLE reserves
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';


LOAD DATA  LOCAL INFILE "/home/kavya-kumar-agrawal/Desktop/c++/DBMS LAB/lab 12/reserves.csv" 
INTO TABLE reserves_details
FIELDS TERMINATED by ','
LINES TERMINATED BY '\n';


update sailor 
set sid = 23 where sid = 22;

-- insert into reserves_details values ()

delete from sailor where sname = 'Dustin';


update boat 
set bid = 23 where bid = 101;

delete from boat where bname = 'Marine';