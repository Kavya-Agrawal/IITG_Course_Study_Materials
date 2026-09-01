-- ////////////TASK 01
CREATE DATABASE week04;
USE week04;

-- ////////////TASK 02 03
CREATE TABLE IF NOT EXISTS T1 (
   origin char(3),
   destination char(3),
   flight_number char(6), 
   dep_time char(5),
   arrival_time char(5)
);

INSERT INTO T1 VALUES ( "BOM", "HYD" , "6E5056" , "21:30" , "22:55" );
INSERT INTO T1 VALUES ( "NAG", "BOM" , "6E5302" , "22:55" , "00:30" );
INSERT INTO T1 VALUES ( "MAA", "BOM" , "6E5367" , "19:00" , "21:10" );

UPDATE T1 
SET origin = "BLR", destination = "MAA" WHERE flight_number = "6E5367";

UPDATE T1 
SET origin = "MAA", destination = "MAA" WHERE flight_number = "6E5367";

DELETE FROM T1 WHERE flight_number = "6E5367";

-- ////////////TASK 04
CREATE TABLE IF NOT EXISTS T2 (
   origin char(3),
   destination char(3),
   flight_number char(6) PRIMARY KEY, 
   dep_time char(5),
   arrival_time char(5)
);

-- ////////////////////TASK 05

INSERT INTO T2
VALUES (
   "BOM",
   "HYD",
   "6E5056",
   "21:30",
   "22:55"
);  
INSERT INTO T2
VALUES (
   "NAG",
   "BOM",
   "6E5056",
   "22:55",
   "00:30"
);  --////////////////// ERROR: Duplicate entry '6E5056' for key 'T2.PRIMARY'

INSERT INTO T2
VALUES (
   "MAA",
   "BOM",
   "6E5367",
   "19:00",
   "21:10"
);  

UPDATE T2 
SET flight_number = "6E5056" WHERE flight_number = "6E5367";
--//////////////////////////ERROR : Duplicate entry '6E5056' for key 'T2.PRIMARY'

DELETE FROM T2 WHERE flight_number = "6E5056";

--//////////////////TASK 06
CREATE TABLE IF NOT EXISTS T3 (
   origin char(3) NOT NULL,
   destination char(3) NOT NULL,
   flight_number char(6) UNIQUE NOT NULL, 
   dep_time char(5) NOT NULL,
   arrival_time char(5) NOT NULL
);

INSERT INTO T3 VALUES ( NULL , "HYD" , "6E5056" , "21:30" , "22:55" );
--//////////////////// Column 'origin' cannot be null

INSERT INTO T3 VALUES ( "BOM" , NULL , "6E5056" , "21:30" , "22:55" );
--//////////////////// Column 'destination' cannot be null

INSERT INTO T3 VALUES ( "BOM" , "HYD" , NULL , "21:30" , "22:55" );
--//////////////////// Column 'flight_number' cannot be null

INSERT INTO T3 VALUES ( "BOM" , "HYD" , "6E5056" , NULL , "22:55" );
--//////////////////// Column 'dep_time' cannot be null

INSERT INTO T3 VALUES ( "BOM" , "HYD" , "6E5056" ,  "21:30" , NULL );
--//////////////////// Column 'arrival_time' cannot be null

--///////////////////////TASK 8
CREATE TABLE IF NOT EXISTS T4 (
   origin char(3) NOT NULL,
   destination char(3) NOT NULL,
   flight_number char(6) PRIMARY KEY, 
   dep_time char(5) NOT NULL,
   arrival_time char(5) NOT NULL
);

INSERT INTO T4 VALUES ( "BOM" , "BOM" , "6E5056" , "21:30" , "22:55" );
INSERT INTO T4 VALUES ( "BOM" , "HYD" , "6E5056" , "22:55" , "21:30" );
--//////////////////////Duplicate entry '6E5056' for key 'T4.PRIMARY'
INSERT INTO T4 VALUES ( "BOM" , "HYD" , "6E" , "21:30" , "22:55" );
INSERT INTO T4 VALUES ( "MOB" , "DYH" , "6E5056" , "22:55" , "21:30" );
--//////////////////////Duplicate entry '6E5056' for key 'T4.PRIMARY'
INSERT INTO T4 VALUES ( "MOBOM" , "DYHYD" , "6E5056-6E5056" , "21:30" , "22:55" );
--//////////////////////Data too long for column 'origin' at row 1


--///////////////////////TASK 10
CREATE TABLE IF NOT EXISTS T5 (
   origin char(3),
   destination char(3),
   flight_number char(6) PRIMARY KEY, 
   dep_time char(5),
   arrival_time char(5)
);

INSERT INTO T5 (
   origin,
   flight_number
)
VALUES (
   "BOM",
   "6E5056"
);

UPDATE T5
SET destination  = "HYD" WHERE flight_number = "6E5056";
UPDATE T5
SET dep_time = "21:30" WHERE flight_number = "6E5056";
UPDATE T5
SET arrival_time = "22:55" WHERE flight_number = "6E5056";

--//////////////TSK 12
CREATE TABLE IF NOT EXISTS T7 (
   flight_number char(6)
);

--//////////////TSK 13

INSERT INTO T7 VALUES ( "6E5056" );
INSERT INTO T7 VALUES ( "6E5302" );
INSERT INTO T7 VALUES ( "6E5367" );

ALTER TABLE T7 ADD origin char(3);

UPDATE T7
SET origin = "BOM" WHERE flight_number = "6E5056";
UPDATE T7
SET origin = "NAG" WHERE flight_number = "6E5302";
UPDATE T7
SET origin = "MAA" WHERE flight_number = "6E5367";

ALTER TABLE T7 ADD destination char(3);

UPDATE T7
SET destination = "HYD" WHERE flight_number = "6E5056";
UPDATE T7
SET destination = "BOM" WHERE flight_number = "6E5302";
UPDATE T7
SET destination = "BOM" WHERE flight_number = "6E5367";

ALTER TABLE T7 ADD dep_time char(5);

UPDATE T7
SET dep_time = "21:30" WHERE flight_number = "6E5056";
UPDATE T7
SET dep_time = "22:55" WHERE flight_number = "6E5302";
UPDATE T7
SET dep_time = "19:00" WHERE flight_number = "6E5367";

ALTER TABLE T7 ADD arrival_time char(5);

UPDATE T7
SET arrival_time = "22:55" WHERE flight_number = "6E5056";
UPDATE T7
SET arrival_time = "00:30" WHERE flight_number = "6E5302";
UPDATE T7
SET arrival_time = "21:10" WHERE flight_number = "6E5367";
